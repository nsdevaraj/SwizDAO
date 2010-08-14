/*
 * This java source file is generated by DAO4J v1.16
 * Generated on Wed May 05 11:29:43 GMT+05:30 2010
 * For more information, please contact b-i-d@163.com
 * Please check http://members.lycos.co.uk/dao4j/ for the latest version.
 */

package com.adams.scrum.pojo;

/*
 * For Table files
 */
public class Files implements java.io.Serializable, Cloneable {

    /* File_ID, PK */
    protected int fileId;

    /* Filename */
    protected String filename;

    /* Filepath */
    protected String filepath;

    /* Filedate */
    protected java.util.Date filedate;

    /* Task_FK */
    protected int taskFk;

    /* Story_FK */
    protected int storyFk;

    /* StoredFileName */
    protected String storedfilename;

    /* Product_FK */
    protected int productFk;
 

    /* File_ID, PK */
    public int getFileId() {
        return fileId;
    }

    /* File_ID, PK */
    public void setFileId(int fileId) {
        this.fileId = fileId;
    }

    /* Filename */
    public String getFilename() {
        return filename;
    }

    /* Filename */
    public void setFilename(String filename) {
        this.filename = filename;
    }

    /* Filepath */
    public String getFilepath() {
        return filepath;
    }

    /* Filepath */
    public void setFilepath(String filepath) {
        this.filepath = filepath;
    }

    /* Filedate */
    public java.util.Date getFiledate() {
        return filedate;
    }

    /* Filedate */
    public void setFiledate(java.util.Date filedate) {
        this.filedate = filedate;
    }

    /* Task_FK */
    public int getTaskFk() {
        return taskFk;
    }

    /* Task_FK */
    public void setTaskFk(int taskFk) {
        this.taskFk = taskFk;
    }

    /* Story_FK */
    public int getStoryFk() {
        return storyFk;
    }

    /* Story_FK */
    public void setStoryFk(int storyFk) {
        this.storyFk = storyFk;
    }

    /* StoredFileName */
    public String getStoredfilename() {
        return storedfilename;
    }

    /* StoredFileName */
    public void setStoredfilename(String storedfilename) {
        this.storedfilename = storedfilename;
    }

    /* Product_FK */
    public int getProductFk() {
        return productFk;
    }

    /* Product_FK */
    public void setProductFk(int productFk) {
        this.productFk = productFk;
    }

    /* Indicates whether some other object is "equal to" this one. */
    public boolean equals(Object obj) {
        if (this == obj)
            return true;

        if (obj == null || !(obj instanceof Files))
            return false;

        Files bean = (Files) obj;

        if (this.fileId != bean.fileId)
            return false;

        if (this.filename == null) {
            if (bean.filename != null)
                return false;
        }
        else if (!this.filename.equals(bean.filename)) 
            return false;

        if (this.filepath == null) {
            if (bean.filepath != null)
                return false;
        }
        else if (!this.filepath.equals(bean.filepath)) 
            return false;

        if (this.filedate == null) {
            if (bean.filedate != null)
                return false;
        }
        else if (!this.filedate.equals(bean.filedate)) 
            return false;

        if (this.taskFk != bean.taskFk)
            return false;

        if (this.storyFk != bean.storyFk)
            return false;

        if (this.storedfilename == null) {
            if (bean.storedfilename != null)
                return false;
        }
        else if (!this.storedfilename.equals(bean.storedfilename)) 
            return false;

        if (this.productFk != bean.productFk)
            return false;

        return true;
    }

    /* Creates and returns a copy of this object. */
    public Object clone()
    {
        Files bean = new Files();
        bean.fileId = this.fileId;
        bean.filename = this.filename;
        bean.filepath = this.filepath;
        if (this.filedate != null)
            bean.filedate = (java.util.Date) this.filedate.clone();
        bean.taskFk = this.taskFk;
        bean.storyFk = this.storyFk;
        bean.storedfilename = this.storedfilename;
        bean.productFk = this.productFk;
        return bean;
    }

    /* Returns a string representation of the object. */
    public String toString() {
        String sep = "\r\n";
        StringBuffer sb = new StringBuffer();
        sb.append(this.getClass().getName()).append(sep);
        sb.append("[").append("fileId").append(" = ").append(fileId).append("]").append(sep);
        sb.append("[").append("filename").append(" = ").append(filename).append("]").append(sep);
        sb.append("[").append("filepath").append(" = ").append(filepath).append("]").append(sep);
        sb.append("[").append("filedate").append(" = ").append(filedate).append("]").append(sep);
        sb.append("[").append("taskFk").append(" = ").append(taskFk).append("]").append(sep);
        sb.append("[").append("storyFk").append(" = ").append(storyFk).append("]").append(sep);
        sb.append("[").append("storedfilename").append(" = ").append(storedfilename).append("]").append(sep);
        sb.append("[").append("productFk").append(" = ").append(productFk).append("]").append(sep);
        return sb.toString();
    }
}