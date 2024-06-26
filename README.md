# Introduction 

Template repository of a delivery service project.
Features a default unreal project and a template plugin in /src/PluginSkyReal/.
To use this template, fork it from DevOps first then go to this file next step.

# Getting Started

1.	Open powershell as admin and run /scripts/Setup-Repository.ps1, it unzips ressources and SkyReal plugins then builds symlinks for /src/PluginSkyReal .  
2.  Open default project and change the template plugin name and description in Edit > Plugins > Project > Other .  
3.	Rename TemplatePlugin directory and .uplugin in /src/PluginSkyReal/Plugins according to the name you defined for your plugin.  
4.	In the powershell file /scripts/Build-UEExtension.ps1 change $PluginName and $ProjectName according to your project. 


# Package
 