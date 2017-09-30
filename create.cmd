dotnet new sln 
dotnet new webapi --name AspCoreNgCli --output AspCoreNgCli
dotnet sln add .\AspCoreNgCli\AspCoreNgCli.csproj
dotnet add .\AspCoreNgCli\AspCoreNgCli.csproj package Microsoft.DotNet.Watcher.Tools

ng new AspCoreNgCli --skip-install --skip-git --style scss