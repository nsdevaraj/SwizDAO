package com.adams.cambook.util;

import flex.messaging.MessageBroker;
import flex.messaging.config.SecurityConstraint;
import flex.messaging.services.Service;
import flex.messaging.services.remoting.RemotingDestination;
import java.beans.*; 
import java.lang.reflect.*;
import java.util.*;

public class RemotingServiceBrowser
{

    public RemotingServiceBrowser()
    { 
        methodsExclude = new ArrayList();
        methodsExclude.add("hashCode");
        methodsExclude.add("getClass");
        methodsExclude.add("wait");
        methodsExclude.add("equals");
        methodsExclude.add("toString");
        methodsExclude.add("notify");
        methodsExclude.add("notifyAll");
        methodsExclude.add("main");
    }

    public String getDestinations(String messageBrokerId)
    {
        StringBuilder result = new StringBuilder();
        MessageBroker broker = MessageBroker.getMessageBroker(messageBrokerId);
        result.append("<remotingDestinations>");
        if(broker != null)
        {
            Service remotingService = broker.getServiceByType("flex.messaging.services.RemotingService");
            if(remotingService != null)
            {
                Map destinations = remotingService.getDestinations();
                Iterator destinationsIterator = destinations.keySet().iterator();
                result.append("<destinations>");
                if(destinationsIterator != null)
                {
                    while(destinationsIterator.hasNext()) 
                    {
                        RemotingDestination destination = (RemotingDestination)destinations.get(destinationsIterator.next());
                        if(destination != null)
                        {
                            result.append("<destination>");
                            result.append((new StringBuilder("<destinationId>")).append(destination.getId()).append("</destinationId>").toString());
                            result.append((new StringBuilder("<adapterName>")).append(destination.getAdapter().getClass().getName()).append("</adapterName>").toString());
                            result.append((new StringBuilder("<source>")).append(destination.getSource()).append("</source>").toString());
                            List channelIds = destination.getChannels();
                            Iterator channelIdsIterator = channelIds.iterator();
                            result.append("<channels>");
                            for(; channelIdsIterator.hasNext(); result.append((new StringBuilder("<channel>")).append((String)channelIdsIterator.next()).append("</channel>").toString()));
                            result.append("</channels>");
                            SecurityConstraint secConstraint = destination.getSecurityConstraint();
                            result.append("<securityConstraint>");
                            if(secConstraint != null)
                            {
                                result.append((new StringBuilder("<securityMethod>")).append(secConstraint.getMethod()).append("</securityMethod>").toString());
                                result.append((new StringBuilder("<securityRoles>")).append(secConstraint.getRoles()).append("</securityRoles>").toString());
                            }
                            result.append("</securityConstraint>");
                            String className = destination.getSource();
                            if(className != null)
                                try
                                {
                                    Class c = Class.forName("com.adams.dt.util.Abstract");
                                    Field fields[] = c.getFields();
                                    result.append("<fields>");
                                    if(fields != null)
                                    {
                                        for(int i = 0; i < fields.length; i++)
                                            result.append((new StringBuilder("<field>")).append(fields[i].toString()).append("</field>").toString());

                                    }
                                    result.append("</fields>");
                                    	
                                    Method methods[] = c.getMethods();
                                    result.append("<methods>");
                                    if(methods != null)
                                    {
                                        for(int i = 0; i < methods.length; i++)
                                            if(methods[i] != null && !methodsExclude.contains(methods[i].getName()))
                                            {
                                                result.append("<method>");
                                                result.append((new StringBuilder("<methodSignature>")).append(methods[i].toString()).append("</methodSignature>").toString());
                                                result.append((new StringBuilder("<methodName>")).append(methods[i].getName()).append("</methodName>").toString());
                                                result.append((new StringBuilder("<returnType>")).append(methods[i].getReturnType().getName()).append("</returnType>").toString());
                                                Class paramClasses[] = methods[i].getParameterTypes();
                                                result.append("<params>");
                                                if(paramClasses != null)
                                                {
                                                    for(int j = 0; j < paramClasses.length; j++)
                                                        if(paramClasses[j] != null)
                                                            result.append((new StringBuilder("<param>")).append(paramClasses[j].getName()).append("</param>").toString());

                                                }
                                                result.append("</params>");
                                                result.append("</method>");
                                            }

                                    }
                                    result.append("</methods>");
                                }
                                catch(ClassNotFoundException e)
                                {
                                    System.out.println(e.getMessage());
                                }
                            result.append("</destination>");
                        }
                    }
                    result.append("</destinations>");
                }
            }
        }
        result.append("</remotingDestinations>");
        return result.toString();
    }

    public String getPublicPropertiesForClasses(String classNames[])
    {
        StringBuilder result = new StringBuilder();
        String className = null;
        ArrayList publicFields = new ArrayList();
        result.append("<classDefinitions>");
        if(classNames != null && classNames.length > 0)
        {
            for(int i = 0; i < classNames.length; i++)
            {
                className = classNames[i];
                if(className != null)
                {
                    result.append("<classDefinition>");
                    try
                    {
                        Class c = Class.forName(className);
                        Field fields[] = c.getFields();
                        Field field = null;
                        if(fields != null)
                        {
                            for(int k = 0; k < fields.length; k++)
                            {
                                field = fields[k];
                                if(field != null)
                                    publicFields.add((new StringBuilder(String.valueOf(field.getName()))).append(",").append(field.getType().getName()).toString());
                            }

                        }
                        try
                        {
                            BeanInfo b = Introspector.getBeanInfo(c);
                            result.append((new StringBuilder("<classSimpleName>")).append(c.getSimpleName()).append("</classSimpleName>").toString());
                            result.append((new StringBuilder("<classFullName>")).append(c.getName()).append("</classFullName>").toString());
                            Package pack = c.getPackage();
                            String packStr = "";
                            if(pack != null)
                                packStr = pack.getName();
                            result.append((new StringBuilder("<packageName>")).append(packStr).append("</packageName>").toString());
                            PropertyDescriptor pds[] = b.getPropertyDescriptors();
                            if(pds != null)
                            {
                                for(int propCount = 0; propCount < pds.length; propCount++)
                                {
                                    PropertyDescriptor pd = pds[propCount];
                                    String propertyName = pd.getName();
                                    Method readMethod = pd.getReadMethod();
                                    Method writeMethod = pd.getWriteMethod();
                                    if(readMethod != null && isPublicAccessor(readMethod.getModifiers()) && writeMethod != null && isPublicAccessor(writeMethod.getModifiers()))
                                        publicFields.add((new StringBuilder(String.valueOf(propertyName))).append(",").append(pd.getPropertyType().getName()).toString());
                                }

                            }
                        }
                        catch(Exception e)
                        {
                            e.printStackTrace();
                        }
                        if(publicFields != null && publicFields.size() > 0)
                        {
                            String temp = null;
                            result.append("<publicFields>");
                            for(int counter = 0; counter < publicFields.size(); counter++)
                            {
                                temp = (String)publicFields.get(counter);
                                if(temp != null)
                                {
                                    String pubTemp[] = temp.split(",");
                                    if(pubTemp.length == 2)
                                    {
                                        result.append("<publicField>");
                                        result.append((new StringBuilder("<publicFieldName>")).append(pubTemp[0]).append("</publicFieldName>").toString());
                                        result.append((new StringBuilder("<publicFieldType>")).append(pubTemp[1]).append("</publicFieldType>").toString());
                                        result.append("</publicField>");
                                    }
                                }
                            }

                            result.append("</publicFields>");
                        }
                    }
                    catch(ClassNotFoundException e)
                    {
                        result.append((new StringBuilder("<classFullName>")).append(className).append("</classFullName>").toString());
                        result.append((new StringBuilder("<error>Problem retrieving ")).append(className).append(" information</error>").toString());
                        System.out.println(e.getMessage());
                    }
                    result.append("</classDefinition>");
                }
            }

        }
        result.append("</classDefinitions>");
        return result.toString();
    }

    public String getPublicMethodsForClasses(String classNames[])
    {
        StringBuilder result = new StringBuilder();
        String className = null;
        result.append("<classDefinitions>");
        if(classNames != null && classNames.length > 0)
        {
            for(int i = 0; i < classNames.length; i++)
            {
                className = classNames[i];
                if(className != null)
                {
                    result.append("<classDefinition>");
                    try
                    {
                        Class c = Class.forName(className);
                        result.append((new StringBuilder("<classSimpleName>")).append(c.getSimpleName()).append("</classSimpleName>").toString());
                        result.append((new StringBuilder("<classFullName>")).append(c.getName()).append("</classFullName>").toString());
                        Package pack = c.getPackage();
                        String packStr = "";
                        if(pack != null)
                            packStr = pack.getName();
                        result.append((new StringBuilder("<packageName>")).append(packStr).append("</packageName>").toString());
                        Method methods[] = c.getMethods();
                        Method method = null;
                        result.append("<methods>");
                        if(methods != null)
                        {
                            for(int j = 0; j < methods.length; j++)
                            {
                                method = methods[j];
                                if(method != null && !methodsExclude.contains(method.getName()))
                                {
                                    result.append("<method>");
                                    result.append((new StringBuilder("<methodSignature>")).append(method.toString()).append("</methodSignature>").toString());
                                    result.append((new StringBuilder("<methodName>")).append(method.getName()).append("</methodName>").toString());
                                    result.append((new StringBuilder("<returnType>")).append(method.getReturnType().getName()).append("</returnType>").toString());
                                    Class paramClasses[] = method.getParameterTypes();
                                    result.append("<params>");
                                    if(paramClasses != null)
                                    {
                                        for(int l = 0; l < paramClasses.length; l++)
                                            if(paramClasses[l] != null)
                                                result.append((new StringBuilder("<param>")).append(paramClasses[l].getName()).append("</param>").toString());

                                    }
                                    result.append("</params>");
                                    result.append("</method>");
                                }
                            }

                        }
                        result.append("</methods>");
                    }
                    catch(ClassNotFoundException e)
                    {
                        result.append((new StringBuilder("<classFullName>")).append(className).append("</classFullName>").toString());
                        result.append((new StringBuilder("<error>Problem retrieving ")).append(className).append(" information</error>").toString());
                        System.out.println(e.getMessage());
                    }
                    result.append("</classDefinition>");
                }
            }

        }
        result.append("</classDefinitions>");
        return result.toString();
    }

    public static void main(String args[])
    {
        RemotingServiceBrowser r = new RemotingServiceBrowser();
        String classNames[] = new String[1];
        classNames[0] = "[Ltestingonly.DTOTest;";
        System.out.println(r.getPublicPropertiesForClasses(classNames));
    }

    public static boolean isPublicAccessor(int modifiers)
    {
        return Modifier.isPublic(modifiers) && !Modifier.isStatic(modifiers);
    }

    private ArrayList methodsExclude;
}