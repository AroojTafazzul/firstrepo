<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:date="http://exslt.org/dates-and-times" extension-element-prefixes="date">
	<!--
   		Copyright (c) 2000-2011 Misys (http://www.misys.com),
  		 All Rights Reserved. 
	-->
	
	<xsl:param name="specific_file"/>
	
	<xsl:output method="text"/>

	<!-- Match template -->
	<xsl:template match="aliases">
			
		<xsl:variable name="specific" select="document($specific_file)"/>
/**
* This class is auto generated (date: <xsl:value-of select="date:date-time()"/>)
* DO NOT WRITE IN THIS FILE
**/
package com.misys.portal.common.resources;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.StringWriter;
import java.lang.reflect.Field;
import java.net.MalformedURLException;
import java.net.URL;

import org.apache.turbine.services.servlet.TurbineServlet;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.misys.portal.Version;
import com.misys.portal.core.util.EngineContext;

/**
 * This class is the repository of URLs used by Portal. These URLs point to XSL and CSS resources. By
 * generating a different class, one can change which resources are read by the application.
 * &lt;p&gt;
 * The intern() call is a technique to ensure that the constants are not inlined by the compiler.
 * &lt;p&gt;
 * This class is auto generated. &lt;br&gt;
 * &lt;b&gt;DO NOT WRITE IN THIS FILE&lt;/b&gt;
 */
public class URLAliasesResourceProvider extends StaticResourceProvider
{
	private static final Logger LOG = LoggerFactory.getLogger(URLAliasesResourceProvider.class);
	
    /*****************/
    /* STANDARD KEYS */
    /*****************/
	<xsl:apply-templates select="alias">
	   <xsl:with-param name="specific" select="$specific"/>
	</xsl:apply-templates>
    
	/*****************/
    /* SPECIFIC KEYS */
    /*****************/
    <xsl:apply-templates select="$specific/aliases/alias" mode="specific"/>
			
	/*
	 * The following empty strings are deprecated, and are temporarily added to ensure that the report
	 * project compiles
	 */
	/* TODO Delete the following */

	/** @deprecated */
	public final static String JAVASCRIPT_COM_CURRENCY_URL = "";

	/** @deprecated */
	public final static String JAVASCRIPT_COM_AMOUNT_URL = "";

	/** @deprecated */
	public final static String JAVASCRIPT_COM_FORM_URL = "";

	/** @deprecated * */
	public final static String JAVASCRIPT_COM_FUNCTIONS_URL = "";
	
	public static final String VERSION_SUFFIX = "?v=" + Version.getVersion();
	

	/**
	 * Return page pointed by an URL.
	 *
	 * @param name URL alias
	 * @return URL
	 */
	public static String getPage(String shortPath) throws Exception
	{
		return getURL(shortPath);
	}

	/**
	 * Return page pointed by an URL, in specified language encoding.
	 *
	 * @param name URL alias
	 * @return URL
	 */
	public static String getPage(String shortPath, String encoding) throws Exception
	{
		if (encoding != null)
		{
			return getURL(shortPath, encoding);
		}

		return getURL(shortPath);
	}

	/**
	 * GTPB3855
	 *
	 * @param webResource
	 * @return a static resource of the doc_root relative to the context path
	 */
	public static String getRelativeLink(String webResource)
	{
		String contextPath = EngineContext.getContextPath();
		if ("/".equals(contextPath))
		{
			return webResource;
		}
		else
		{
			return contextPath + webResource;
		}
	}


	/**
	 * @param webResource
	 * @return a static resource of the doc_root relative to the context path
	 *
	 */
	public static String getRelativeLinkForImages(String webResource)
	{
		String contextPath = EngineContext.getContextPath();
		
		if ("/".equals(contextPath))
		{
			return webResource + VERSION_SUFFIX;
		}
		else
		{
			return contextPath + webResource + VERSION_SUFFIX; 
		}
	}
	
	
	/**
	 * Method used to read the content of a file and return its content in the output string.
	 *
	 * @author Olivier
	 */
	private static String getURL(String url) throws IOException
	{
		int capacity = 1024;

		InputStream is = new URL(url).openStream();
		ByteArrayOutputStream buffer = new ByteArrayOutputStream();

		// now process the InputStream...
		byte[] bytes = new byte[capacity];

		int readCount = 0;
		while ((readCount = is.read(bytes)) > 0)
		{

			buffer.write(bytes, 0, readCount);
		}
		is.close();
		return buffer.toString();
	}

	/**
	 * Method used to read the content of a file and return its content in the output string. The charset
	 * is fetched from the language resources.
	 *
	 * @author Olivier
	 */
	private static String getURL(String url, String encoding) throws IOException
	{
		int capacity = 1024;

		InputStream is = new URL(url).openStream();
		InputStreamReader reader = new InputStreamReader(is, encoding);

		// now process the InputStream...
		char[] chars = new char[capacity];
		StringWriter bos = new StringWriter();

		int readCount = 0;
		while ((readCount = reader.read(chars)) > 0)
		{
			bos.write(chars, 0, readCount);
		}

		is.close();
		reader.close();

		return bos.toString();
	}

	/**
	 * @param codeName
	 * @return a code value from its code name
	 */
	public static String getURLFromCode(String codeName)
	{
		try
		{
			Field field = URLAliasesResourceProvider.class.getDeclaredField(codeName);
			if (field.getType() == String.class)
			{
				return (String) field.get(null);
			}
		}
		catch (Exception e)
		{
			LOG.error("Unkown url: " + codeName);
		}
		return null;
	}

	/**
	 * @param constant a value of a property above
	 * @return url computed for the client
	 */
	public static String getWebSource(String constant)
	{
		// return constant;
		return getRelativeLink(constant);
	}

	/**
	 * @param constant a value of a property above
	 * @return url computed for the client
	 */
	public static String getWebSource(String constant, String language)
	{

		StringBuffer result = new StringBuffer();
		int indexOfextension = constant.indexOf(".");
		// get the file name without extension
		result.append(constant.substring(0, indexOfextension));
		// file name + "_"+ language + file extension
		result.append("_")
				.append(language)
				.append(constant.substring(indexOfextension, constant.length()));

		return getRelativeLink(result.toString());
	}

	/**
	 * Return the URL (without the language extension).
	 *
	 * @param name URL alias
	 * @return URL
	 */
	public static URL resolveURL(String name)
	{
		try
		{
			if ((name != null) &amp;&amp; name.startsWith("/"))
			{
				return TurbineServlet.getResource(name);
			}
			return new URL(name);
		}
		catch (MalformedURLException e)
		{
			LOG.error("Unable to resolve URL: " + name, e);
			return null;
		}
	}

	/**
	 * Return URL.
	 *
	 * @param name URL alias
	 * @return URL
	 */
	public static String resolveURLFromLanguage(String name, String userLanguage)
	{
		StringBuffer result = new StringBuffer();
		String language = (userLanguage != null) ? userLanguage : DefaultResourceProvider.LANGUAGE;

		int indexOfextension = name.indexOf(".");
		if (indexOfextension != -1)
		{
			// get the file name without extension
			result.append(name.substring(0, indexOfextension));
			// file name + "_"+ language + file extension
			result.append("_").append(language).append(name.substring(indexOfextension));
			return resolveURL(result.toString()).toString();
		}

		return resolveURL(name).toString();
	}

	/**
	 */
	public java.lang.String getDomain()
	{
		return "URLAliasesResourceProvider";
	}

	/**
	 *
	 */
	public void initialize()
	{}
}
	</xsl:template>
	
	<xsl:template match="alias">
		<xsl:param name="specific"/>
		<xsl:variable name="key" select="@name"/>
		<xsl:choose>
		<xsl:when test="$specific/aliases/override[@name=$key] != ''">
	public final static String <xsl:value-of select="normalize-space($key)"/> = "<xsl:value-of select="normalize-space($specific/aliases/override[@name=$key])"/>".intern();
		</xsl:when>
		<xsl:otherwise>
	public final static String <xsl:value-of select="normalize-space($key)"/> ="<xsl:value-of select="normalize-space(.)"/>".intern();
		</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="alias" mode="specific">
	public final static String <xsl:value-of select="normalize-space(@name)"/> ="<xsl:value-of select="normalize-space(.)"/>".intern();
	</xsl:template>
</xsl:stylesheet>
