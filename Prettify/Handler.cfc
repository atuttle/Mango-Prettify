<!---
LICENSE INFORMATION:

Copyright 2010, Adam Tuttle

Licensed under the Apache License, Version 2.0 (the "License"); you may not
use this file except in compliance with the License.

You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed
under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
CONDITIONS OF ANY KIND, either express or implied. See the License for the
specific language governing permissions and limitations under the License.

VERSION INFORMATION:

This file is part of Prettify.
--->
<cfcomponent displayname="Handler" extends="org.mangoblog.plugins.BasePlugin">
	<cffunction name="init" access="public" output="false" returntype="any">
		<cfargument name="mainManager" type="any" required="true" />
		<cfargument name="preferences" type="any" required="true" />
		<cfset setManager(arguments.mainManager) />
		<cfset setPreferencesManager(arguments.preferences) />
		<cfset setPackage("com/fusiongrokker/plugins/Prettify") />
		<cfreturn this/>
	</cffunction>
	<cffunction name="setup" hint="This is run when a plugin is activated" access="public" output="false" returntype="any">
		<cfreturn "Plugin activated" />
	</cffunction>
	<cffunction name="unsetup" hint="This is run when a plugin is de-activated" access="public" output="false" returntype="any">
		<cfreturn "Plugin De-activated" />
	</cffunction>
	<cffunction name="handleEvent" hint="Asynchronous event handling" access="public" output="false" returntype="any">
		<cfargument name="event" type="any" required="true" />
		<!--- doesn't respond to any asynch events --->
		<cfreturn />
	</cffunction>
	<cffunction name="processEvent" hint="Synchronous event handling" access="public" output="false" returntype="any">
		<cfargument name="event" type="any" required="true" />
		<cfset var d = event.outputData />
		<cfif event.name eq "beforeHtmlHeadEnd">
			<cfset d = d & "#chr(10)#<!--prettify.js styles--><link rel='stylesheet' href='#getAssetPath()#assets/prettify.css' type='text/css' media='screen' />" />
		<cfelseif event.name eq "beforeHtmlBodyEnd">
			<cfset d = d & "#chr(10)#<!--enable prettify.js-->" />
			<cfset d = d & "#chr(10)#<script type=""text/javascript"" src=""#getAssetPath()#assets/prettify.js""></script>" />
			<cfset d = d & "#chr(10)#<script type=""text/javascript"">addEventListener('load',function(event){prettyPrint()},false);</script>" />
		</cfif>
		<cfset event.outputData = d />
		<cfreturn arguments.event />
	</cffunction>
</cfcomponent>