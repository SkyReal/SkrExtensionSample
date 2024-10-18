
# Introduction 

Template repository used to demonstrate how to build sample extensions pack installer for SkyReal VR software.

# Getting Started
To Setup the repository, please follow these steps:
1.	Call command line `git submodule update --init --recursive`
2.	Open powershell as admin in the directory `\ressources\SkrExtensionScripts\scripts` and run script `./Setup-Repository.ps1`. This script will download SkyReal plugins from SkyReal servers and symlinks to project plugin directory.
	
# Play with the sample
To open the sample project, open `\src\Playground.uproject` with Unreal editor after repository setup.
The plugin `SampleSkrExtension` contains sample extension points available in SkyRealVR.

# Build your own plugins

## Fork repository
This repository contains LFS files. Sometimes (for AzureDevOps for example), the helper UI use to fork repository can failed to sync LFS pointers. The manual way to do so it to:
1. Create a new empty repository and copy its URL (ie: git://example.com/git.git/)
2. Clone the template repository somewhere
3. Open git batch in the repository
4. Write command `git remote set-url origin git://example.com/git.git/`
5. Write command `git push`
5. Write command `git lfs push`

## Build repository
To customize this template for building your own extension plugins, follow these steps after repository setup:
1. Delete following sample project in `\src\Plugins`:
	* `SampleSkrExtension`
	* `SkrCat_RightMenuExtension`
2. Open `\src\Playground.uproject` with Unreal editor and create as many plugins as needed.
	* Go to `edit\plugins`
	* On the top left corner, click `+ Add`
	* Select `Content Only` and specify Author, Description and Plugin Name (this information will be required in following steps)
	* Click on `Create Plugin`
3. Edit file `Variables.json` in the root folder
	*  In the array field `ExtensionsPlugins`, add an entry foreach plugin created before with the name of the plugin.
	* In the array field `SkyRealPluginsToIgnore`, add every SkyRealVR plugin names not required for your project (fewer there are plugin, faster the compilation is).
	* In the string field `InstallerName`, specify the name of the installer of your plugins pack that will appear in windows program list .
	* In the string field `ProductUpgradeCode`, generate a unique Guid that will be used to manage auto-uninstall when upgrading plugin.

# Build installers

To build your plugin, few steps are required:
* Download and install NSIS. If NSIS is not installed in the default directory, add to your environment variable key pair value `NSIS` => `c:\Path\to\NSIS\Directory\`
* Install Unreal editor (version used by your project) and add to your environment variable key pair value `UE5_X_INSTALL_DIR` => `c:\Path\to\UE_XX\Directory\` where X in the minor version of Unreal (by default, the path is `C:\Program Files\Epic Games\UE_5.X`). To specify another environment key value, you can edit `Variables.json` in the root folder of the repository on field `UnrealEditorEnvironmentVariable`.
* Add content into every plugin of your project. Is a plugin is empty, the build process will failed. 

Once theses prerequisites are satisfied, you can open powershell as admin in the directory `\ressources\SkrExtensionScripts\scripts` and run script `./Build-Repository.ps1`.
The result of your work will be placed into:
* `Output\Build` (defined in `Variables.json` field `OutputBuildDir` for cook content.
* `Output\Install` (defined in `Variables.json` field `OutputInstallDir` for installer output directory.

# Deploy installer
To deploy installer, take care to package both .exe and .skrapp file on the client computer. By default, when installing a new version of a plugin pack, it will automatically uninstall older version. To avoid this, change `ProductUpgradeCode` in the `Variables.json` file.
The installer will automatically create a `.skrlnk` into directory `C:\ProgramData\Skydea\skyrealvr\X.XX\extensions` that will contains the path to the SkrExtension.json file of the plugin pack.

# Daily life work
When developing and testing your plugin code, creating an installer can be too heavy. Another way to improve process time is to:
1. Setup your repository if not already done
2. Open powershell as admin in the directory `\ressources\SkrExtensionScripts\scripts` and run script `./Build-UEExtension.ps1`.
3. In the output directory (`\Output\Build` by default that can be changed in `Variables.json`), cut the file `EXTENSION_NAME.skrlnk` (where `EXTENSION_NAME` is the name installer specified in the `Variables.json` file)
4. Paste it in the directory `C:\ProgramData\Skydea\skyrealvr\X.XX\extensions` where X.XX is the version number of SkyRealVR.

Now, each time SkyRealVR (version X.XX) will run, it will automatically load or latest version build using script `./Build-UEExtension.ps1`.

If, for some reasons, you need to override some variables of the `Variables.json` without comit them into git, you can create a `Variables_local.json` file in the same directory. 
The file (that is in the .gitignore) will automatically be loaded to override data of `Variables.json` (you don't need to override every member, only the one required for your local work).

# Upgrade SkyReal version/branch
When upgrading your project to a newer version of SkyRealVR, follow these steps:
1. Edit file `Variables.json` in the root folder
	* Edit the field `SkyRealPluginRelease` to specify the current version of SkyRealVR (it could either be X.XX of master).
	* Edit the field `SkyRealPluginPatch` to specify the current patch version of SkyRealVR (it could either be X.XX.X of latest).
	* Edit the field `SkyRealVersion` to specify the current version of SkyRealVR (it could only be X.XX).
	* Edit the field `UnrealEditorEnvironmentVariable` to specify the new Unreal editor environment variable. Usually, the version of Unreal changes at each SkyRealVR version update.
2. If you use the Azure pipelines, edit the file `azure-pipeline\templates\jobs\build-ue-extensions.yml` and edit `job/pool/demands/UE5_X_INSTALL_DIR` into the Unreal environment variable you use.

# Use Azure pipelines to build your data
To support Azure pipelines for automation builds, create a custom agent with the following prerequisites:
* NSIS installed (same as getting started)
* Unreal editor installed (add environment variable specified in `Variables.json` and take sure it's the same as in the file `azure-pipeline\templates\jobs\build-ue-extensions.yml` .
* Add manually the capacity `UEAgent` to your azure agent.