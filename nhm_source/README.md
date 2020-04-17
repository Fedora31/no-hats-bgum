# no_hats_bgum source files
These are the folders containing the source files of the mod. The big majority of the files are there, but I lost a chunk of them a while back.

- the "0kb_files" folder is where the hats that only need their 2 .vtx files to be 0kb to disappear are stored. These hats aren't interfering with bodygroups.
- the "decompiled" folder is where the .qci files of all the hats that replace a bodygroup and need to be recompiled are stored.

If you found a bug (e.g. missing source files for a hat) and want to help, you can fork this and create a pull request.

## compiling
You can compile the mod yourself using [crowbar](https://steamcommunity.com/groups/CrowbarTool). Select a folder of your choice as the Work Folder, the "decompiled" folder as the QC input and go make yourself a sandwich, it's gonna take a while.

As of writing there is no way to compile the mod on Linux because Valve didn't feel like porting the sudiomdl executable. (you can use a VM it's what I do)

## after compiling
You can now merge the models folder in "0kb_files" with the one in your folder. Give your folder a cool name, open it with the vpk.exe located at `steamapps\common\Team Fortress 2\bin` and voilà!