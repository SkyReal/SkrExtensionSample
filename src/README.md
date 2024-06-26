# Introduction 
This template project is used to build a installer of a SkyReal VR extension plugin. 

# Getting Started
To start using this template: 
1.	Open file `Variables.json` and fill the following values
	1. **ExtensionsPlugins**: Add here the names of the futur plugins you will create.
	2. **InstallerName**: The name of the pack that will be installed within SkyRealVR
	3. **ProductUpgradeCode**: A unique guid for your installer/uninstaller
	4. **Version**: The version of your plugin
	5. **UnrealEditorEnvironmentVariable:** The environment variable used to target the instalation path of Unreal editor
	6. **SkyRealRelease**: The release targeted by the extension plugin
	7. **SkyRealPatch**: The path name targeted by the extension plugin
2.	Run script scripts `.\scripts\Setup-Repository.ps1` with powershell 
3.	Open Unreal project `\src\Playground.uproject` with the same Unreal version used inside **UnrealEditorEnvironmentVariable**
4.	Create as many plugins as added in **ExtensionsPlugins** and use the same same.
5.	Add some extension content to every plugins

# Build and Test
To Build the plugin:
1. Take care every plugins have content
2. Using powershell in administrator mode, call `.\scripts\Build-UEExtension.ps1`
3. Retreive the result in **OutputDir\PluginName** where **PluginName** is the name of your plugins.

To build the installer:
1. Build the plugin (see previous step)
2. Using powershell in administrator mode, call `.\scripts\Build-Installer.ps1`