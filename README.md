# EamonConverter

Converts extracted Eamon adventure game files from Apple II dsk images to formats suitable for use with modern versions of the Eamon system, such as [this one](https://github.com/kdechant/eamon) by Keith Dechant.

## Requirements

### System Requirements

* macOS Mojave V10.14.4 +
* Swift 5 +

You may be able to compile EamonConverter for other operating systems supporting Swift 4+, but it has not been tested.

### Supported Eamon Systems

* ProDOS Eamon system
* Eamon V4, 5, and 6 -- (not fully tested, but should work)
* Eamon V7 -- (not yet supported)

## Disclaimer

This utility is very much 
a work in progress. Usage is particularly barebones at present.

Swift is not my first programming language; there are still gaps in my understanding of it. There are probably more elegant ways of accomplishing parts of this code. That said, I'd been wanting a project to sink my teeth into some Swift development, and this seemed like as good a one as any. 

## Usage

At the command line, change to the directory which includes your Apple II source files, and run EamonConverter.

### Source Files

Source files should be extracted from the Apple II disk image with a tool such as [DiskM8](https://github.com/paleotronic/diskm8), or another Apple disk image management utility. In the case of Dskalyzer, use the .txt (not .asc version) of the database files, and use the .asc (not the .bas version) of the Applesoft Basic program files.

Source files should follow the below naming conventions. You will need to rename the source files in most cases.

* Database files
    * eamon.name.txt
    * eamon.desc.txt
    * eamon.room.name.txt
    * eamon.rooms.txt
    * eamon.artifacts.txt
    * eamon.monsters.txt
* Applesoft Basic Programs
    * eamon.intro.txt

### Generated Files

All data from the Eamon database files is converted to JSON according to object type as specified in the documentation for [Eamon Remastered](https://github.com/kdechant/eamon) by Keith Dechant. Some additional processing is performed on strings (e.g. object descriptions, names, etc.) to improve human readability.

* rooms.json
* artifacts.json
* effects.json
* monsters.json
* dungeon.json — (full archive of all adventure data)

Printed text from the adventure's intro Applesoft Basic program is extracted and saved to a plain test file, suitable for further editing and copying into a modern system. Due to the nature of Applesoft Basic, some strings printed provided other functionality and will be extracted despite not being part of the intro text. (e.g. "PR#3" activated 80 column mode for Apple II video output.)

* intro.txt

#### Additional String Processing

After importing the resulting data into a modern system, you will almost certainly need to perform some additional editing. The processing provided by EamonConverter is to make the process less painful by adhere to some predictable rules that will get you most of the way to where you're going.

* Whitespace is collapsed in Room, Artifact, Effect, and Monster descriptions.
* Artifact names are converted to lowercase. (e.g. "bag of gold coins")
* Monster names are converted to capitalized case. (e.g. "Brave Sir Robin")
* Dungeon title is converted to capitalized case.

## ToDo

* Test support for 10 direction-based Eamon adventures
* Implement detection of Eamon version
* Implement support for Eamon V7
* Debug issues for DOS 3.3
* Implement command line argument for source files' location
* Implement command line argument for help
