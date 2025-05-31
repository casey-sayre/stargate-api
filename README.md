# Stargate API Exercise Journal (Sayre)

## Setup API
* Extracted file `tech_exercise_v.0.0.4.tgz`.
* Navigated to the api directory `tech_review/tech_exercise/package/exercise1/api`.
* Added a `.devcontainer/devcontainer.json` file to establish a dotnet 8.0 environment in `Debian 12` `Bookworm`.
* When prompted by vs code, reopened folder in container.
* Added a `.gitignore` file. `obj` and `bin` are ignored.
* Ran `git init .`. Renamed `master` branch to `main`.
* Added and committed all existing files (except `obj` and `bin`) to main.
* Added and committed `devcontainer.json` and `.gitignore` to main.
## Examine API Code
* Created feature branch `exercise`.
* Added `.vscode/launch-template.json` and `.vscode/tasks-template.json` to the repo for reference.
* From devcontainer Terminal entered `dotnet dev-certs https --trust` to get past certificate issue.
* Swagger renders successfully at `http://localhost:5204/swagger/index.html`.
* Found issues in default application settings file `appsettings.json`.
  * Removed the Development connection string. Moved to `appsettings.Development.json`.
  * Removed Development wildcard value from AllowedHosts. Moved to `appsettings.Development.json`.
* Created database successfully from Terminal with `dotnet ef database update`.
* Swagger GET PERSON succeeds with 0-length array of Person items.
* TODO: Found that CORS is not set up.
  * Add CORS in `Program.cs`.
  * NOTE: On AllowedHosts, `null` setting gets coalesced to empty string.
  * NOTE: Methods and Headers are not restricted.
### Examine Build Warnings
There were six warnings reported by MSBuild. Changed code to fix them.
* CreateAstronautDuty handler had a possible null Person (name not found). Return a result with Success false and desciptive Message.
* GetAstronautDutiesByName handler had a possible null Person (name not found). Return a result with Success false and desciptive Message.
* AstronautDetail added one-to-one relationship with person and fixed possible null Person property.
* AstronautDuty added many-to-one relationship with person and fixed possible null Person property.