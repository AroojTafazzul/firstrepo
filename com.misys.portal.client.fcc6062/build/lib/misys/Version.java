package com.misys.portal;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Gives current Portal version
 */
public final class Version
{
	private static final Log LOG = LogFactory.getLog(Version.class);

	/**
	 * The value of this constant will be replaced by the build process.
	 **/
	private static final String VERSION = "5";

	/**
	 * The value of this constant will be replaced by the build process.
	 **/
	private static final String BUILD = "1";

	public static String getBuildNumber()
	{
		return BUILD;
	}

	public static String getVersion()
	{
		return VERSION;
	}

	public static void main(String[] args)
	{
		LOG.info("Current version of Portal is: " + VERSION + ".");
	}
}