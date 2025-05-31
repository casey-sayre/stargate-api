# Stargate API Exercise Journal (Sayre)

## Setup API
* Extracted file `tech_exercise_v.0.0.4.tgz`.
* Navigated to the api directory `tech_review/tech_exercise/package/exercise1/api`.
* Added a `.devcontainer/devcontainer.json` file to establish a dotnet 8.0 environment in `Debian 12` `Bookworm`.
* Added a `.gitignore` file. `obj` and `bin` are ignored.
* Ran `git init .`. Renamed `master` branch to `main`.
* Added and committed all existing files (except `obj` and `bin`) to main.
* Added and committed `devcontainer.json` and `.gitignore` to main.
## Examine API Code
* Created feature branch `exercise`.
* Found issues in default application settings file `appsettings.json`.
  * Removed the Development connection string. Moved to `appsettings.Development.json`.
  * Removed Development wildcard value from AllowedHosts. Moved to `appsettings.Development.json`.
* Found that CORS is not set up.
  * Added CORS in `Program.cs`.
  * On AllowedHosts, `null` setting gets coalesced to empty string. NOTE.
  * Methods and Headers are not restricted. NOTE.