#  EamonConverter

## Notes

This utility is very much 
a work in progress. Usage is particularly rough at present, but it will be refined in time.


## Usage

At the command line, change to the directory which includes your Apple II source files, and run EamonConverter.


### Source Files

Source files should be extracted from the Apple II disk image with a tool such as [Dskalyzer](https://github.com/paleotronic/dskalyzer), or other Apple disk image management system. In the case of Dskalyzer, use the .txt not .asc version of the database files, and the .asc version of the Applesoft Basic program files.

Source files should follow these naming conventions:

* Database files
    * eamon.name.txt
        * eamon.desc.txt
            * eamon.room.name.txt
                * eamon.artifacts.txt
                    * eamon.monsters.txt
                    * Applesoft Basic Programs
                        * eamon.intro.txt

### Generated Files

All data from the Eamon database files is converted to JSON according to object type as follows:

* rooms.json
* artifacts.json
* effects.json
* monsters.json

Printed text from the adventure's intro Applesoft Basic program is extracted and saved.

* intro.txt

