# PartDb-Altium-Connector

[![license](https://img.shields.io/github/license/:user/:repo.svg)](LICENSE)


## Table of Contents

- [Compatibility](#compatibility)
- [Background](#background)
- [Requirements](#requirements)
- [Coexistence with KiCad](#coexistence)
- [Install](#install)
- [Usage](#usage)
- [Note](#note)
- [Maintainers](#maintainers)
- [Contributing](#contributing)
- [License](#license)


## Compatibility
This version was tested with Part-DB-server 1.16.1 and 1.17.0.
Other versions may be also compatible.


## Background
The code in this repository connects [Part-DB-server](https://github.com/Part-DB/Part-DB-server) with [Altium Designer](https://www.altium.com/de/altium-designer).
You can define a symbol and up to three footprints (comma separated) for a part under the EDA-Settings (that is originally used for the KiCad API).
The parts are then browseable in Altium.
Footprints and Symbols remains as files in Altium (as a Altium-Library).


## Requirements
- PartDb is running with mySQL (and you have access to it)
- Altium is connected via ODBC to the database server


## Coexistence with KiCad
The view that generates the part listing for altium cuts away the prefix of the library name including the first ':' for symbols and footprints.
This allows the coixistence of KiCad with Altium libraries as long as the same name for the part is used in both worlds.
In KiCad you can add the same Altium library files to your symbol and footprint libraries (or use native libs instead).
Note: No ':' is allowed in the library names because of the cut of the prefix!

![View on MySql-Server](/doc/KiCadFootprintLibSettings.jpg)
![View on MySql-Server](/doc/KiCadSymbolLibSettings.jpg)


## Install
- Replace the "yourServerName" string in the SQL files with your servername or IP of the PartDb server.
- Setup the views parallel to the tables of PartDb on your mySql-Server. The files starting with "create..." are just a help if needed. [HeidiSQL](https://www.heidisql.com) was a good tool therefor.
  - src/allParts (required)
  - src/datasheets (required)
  - src/images (optional, if not used other views (files) have to be edited)
- The views for datasheets/images returns the first datasheet/image that is found for a part. This datasheet url can be used for the symbol (in Altium) as reference (See also: https://forum.live.altium.com/#/posts/258269/833879).
- Setup a ODBC connection [mysql ODBC connector](https://dev.mysql.com/downloads/connector/odbc/) with your PartDb database.

![View on MySql-Server](/doc/ViewOnPartDb.jpg)


### Settings in Altium
- setup a database connection (DbLib) and connect to your database via ODBC
- use the settings from the image "AltiumSettings". Note that in your case the table/view is called "allParts" or the name that you have given
- the symbols and footprints must be available in file libraries (PcbLib/SchLib)
- In the "Connection string" use your own password, server and port settings
- In "Advanced..." under "Source of Connection" make sure that "Quote Tables" is not checked. 
  
![Altium Settings](/doc/AltiumDbLibSettings.jpg)


## Usage
After setting up the columns you should see something like the following.
![Altium Symbol Reference](/doc/ComponentsView.jpg)

![Altium Parts](/doc/AltiumDbColumns.jpg)


## Note
- Footprints and Symbols are stored as Library-Files in Altium
- This is just an example and experimental
- The import into Altium is done with "views" wich means that this requires some performance from the database server.

  
## Maintainers

[@electronics4fun](https://github.com/electronics4fun)


## Contributing

Feel free to dive in! [Open an issue](https://github.com/electronics4fun/PartDb-Altium-Connector/issues/new) or submit PRs.


## License

[MIT](LICENSE)






