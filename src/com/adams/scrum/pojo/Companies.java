package com.adams.scrum.pojo;

public class Companies implements java.io.Serializable, Cloneable {
   	protected int companyId;
	protected String companyname;
	protected String companycode;
	protected byte[] companylogo;
	protected String companyCategory; 
	protected String companyAddress;
	protected String companyPostalCode;
	protected String companyCity;
	protected String companyCountry;
	protected String companyPhone;
    
    /**
	 * @return the companyId
	 */
	public int getCompanyId() {
		return companyId;
	}

	/**
	 * @param companyId the companyId to set
	 */
	public void setCompanyId(int companyId) {
		this.companyId = companyId;
	}

	/**
	 * @return the companyname
	 */
	public String getCompanyname() {
		return companyname;
	}

	/**
	 * @param companyname the companyname to set
	 */
	public void setCompanyname(String companyname) {
		this.companyname = companyname;
	}

	/**
	 * @return the companycode
	 */
	public String getCompanycode() {
		return companycode;
	}

	/**
	 * @param companycode the companycode to set
	 */
	public void setCompanycode(String companycode) {
		this.companycode = companycode;
	}

	/**
	 * @return the companylogo
	 */
	public byte[] getCompanylogo() {
		return companylogo;
	}

	/**
	 * @param companylogo the companylogo to set
	 */
	public void setCompanylogo(byte[] companylogo) {
		this.companylogo = companylogo;
	}

	/**
	 * @return the companyCategory
	 */
	public String getCompanyCategory() {
		return companyCategory;
	}

	/**
	 * @param companyCategory the companyCategory to set
	 */
	public void setCompanyCategory(String companyCategory) {
		this.companyCategory = companyCategory;
	}

	/**
	 * @return the companyAddress
	 */
	public String getCompanyAddress() {
		return companyAddress;
	}

	/**
	 * @param companyAddress the companyAddress to set
	 */
	public void setCompanyAddress(String companyAddress) {
		this.companyAddress = companyAddress;
	}

	/**
	 * @return the companyPostalCode
	 */
	public String getCompanyPostalCode() {
		return companyPostalCode;
	}

	/**
	 * @param companyPostalCode the companyPostalCode to set
	 */
	public void setCompanyPostalCode(String companyPostalCode) {
		this.companyPostalCode = companyPostalCode;
	}

	/**
	 * @return the companyCity
	 */
	public String getCompanyCity() {
		return companyCity;
	}

	/**
	 * @param companyCity the companyCity to set
	 */
	public void setCompanyCity(String companyCity) {
		this.companyCity = companyCity;
	}

	/**
	 * @return the companyCountry
	 */
	public String getCompanyCountry() {
		return companyCountry;
	}

	/**
	 * @param companyCountry the companyCountry to set
	 */
	public void setCompanyCountry(String companyCountry) {
		this.companyCountry = companyCountry;
	}

	/**
	 * @return the companyPhone
	 */
	public String getCompanyPhone() {
		return companyPhone;
	}

	/**
	 * @param companyPhone the companyPhone to set
	 */
	public void setCompanyPhone(String companyPhone) {
		this.companyPhone = companyPhone;
	}
	
	 /* Indicates whether some other object is "equal to" this one. */
    public boolean equals(Object obj) {
        if (this == obj)
            return true;

        if (obj == null || !(obj instanceof Companies))
            return false;

        Companies bean = (Companies) obj;

        if (this.companyId != bean.companyId)
            return false;

        if (this.companyname == null) {
            if (bean.companyname != null)
                return false;
        }
        else if (!this.companyname.equals(bean.companyname)) 
            return false;
        
        
        if (this.companylogo == null) {
            if (bean.companylogo != null)
                return false;
        }else {
            if (bean.companylogo == null)
                return false;
            else {
                if (companylogo.length != bean.companylogo.length)
                    return false;
                for (int i=0;i<bean.companylogo.length;i++) {
                    if (this.companylogo[i] != bean.companylogo[i])
                        return false;
                }
            }
        }
        
        if (this.companycode == null) {
            if (bean.companycode != null)
                return false;
        }
        else if (!this.companycode.equals(bean.companycode)) 
            return false;
        
        if (this.companyCategory == null) {
            if (bean.companyCategory != null)
                return false;
        }
        else if (!this.companyCategory.equals(bean.companyCategory)) 
            return false;
        
        if (this.companyAddress == null) {
            if (bean.companyAddress != null)
                return false;
        }
        else if (!this.companyAddress.equals(bean.companyAddress)) 
            return false;

        if (this.companyPostalCode == null) {
            if (bean.companyPostalCode != null)
                return false;
        }
        else if (!this.companyPostalCode.equals(bean.companyPostalCode)) 
            return false;
        
        if (this.companyCity == null) {
            if (bean.companyCity != null)
                return false;
        }
        else if (!this.companyCity.equals(bean.companyCity)) 
            return false;
        
        if (this.companyCountry == null) {
            if (bean.companyCountry != null)
                return false;
        }
        else if (!this.companyCountry.equals(bean.companyCountry)) 
            return false;
        
        if (this.companyPhone == null) {
            if (bean.companyPhone != null)
                return false;
        }
        else if (!this.companyPhone.equals(bean.companyPhone)) 
            return false;

        return true;
    }
    
    /* Creates and returns a copy of this object. */
    public Object clone()
    {
    	Companies bean = new Companies();
        bean.companyId = this.companyId;
        bean.companyname = this.companyname;
        bean.companycode = this.companycode;
        bean.companylogo = this.companylogo;
        bean.companyCategory = this.companyCategory;
        bean.companyAddress = this.companyAddress;
        bean.companyPostalCode = this.companyPostalCode;
        bean.companyCity = this.companyCity;
        bean.companyCountry = this.companyCountry;
        bean.companyPhone = this.companyPhone;
        
        int companylogoLength = -1;
        if (this.companylogo != null)
        	companylogoLength = this.companylogo.length;
        if (companylogoLength > 0)
        {
            byte[] companylogoArray = new byte[companylogoLength];
            bean.companylogo = companylogoArray;
            System.arraycopy(this.companylogo, 0, companylogoArray, 0, companylogoLength);
        }        
        return bean;
    }    

    /* Returns a string representation of the object. */
    public String toString() {
        String sep = "\r\n";
        StringBuffer sb = new StringBuffer();
        sb.append(this.getClass().getName()).append(sep);
        sb.append("[").append("companyId").append(" = ").append(companyId).append("]").append(sep);
        sb.append("[").append("companyname").append(" = ").append(companyname).append("]").append(sep);
        sb.append("[").append("companycode").append(" = ").append(companycode).append("]").append(sep);
        sb.append("[").append("companylogo").append(" = ").append(companylogo).append("]").append(sep);
        sb.append("[").append("companyCategory").append(" = ").append(companyCategory).append("]").append(sep);
        sb.append("[").append("companyAddress").append(" = ").append(companyAddress).append("]").append(sep);
        sb.append("[").append("companyPostalCode").append(" = ").append(companyPostalCode).append("]").append(sep);
        sb.append("[").append("companyCity").append(" = ").append(companyCity).append("]").append(sep);
        sb.append("[").append("companyCountry").append(" = ").append(companyCountry).append("]").append(sep);
        sb.append("[").append("companyPhone").append(" = ").append(companyPhone).append("]").append(sep);       
        return sb.toString();
    }    
       
	public Companies() {
    }	
}