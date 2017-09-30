# Creating ASP.NET Core Web API project with Angular CLI

## Create a project


    dotnet new sln 
    dotnet new webapi --name AspCoreNgCli --output AspCoreNgCli
    dotnet sln add .\AspCoreNgCli\AspCoreNgCli.csproj
    dotnet add .\AspCoreNgCli\AspCoreNgCli.csproj package Microsoft.DotNet.Watcher.Tools
    
    ng new AspCoreNgCli --skip-install --skip-git --style scss

## Configure ASP.NET Core

Next, we’ll install the dependencies, ensure we don’t get TypeScript compile errors, and configure our server.

1. Open your .csproj file

Since we will eventually have TypeScript files in our project, we should also disable any TypeScript compilation errors.

    <PropertyGroup>
      <TargetFramework>netcoreapp2.0</TargetFramework>
      <TypeScriptCompileBlocked>true</TypeScriptCompileBlocked>
    </PropertyGroup>

2. Enable automatic re-compilation for ASP.NET Core

Edit the .csproj file and add add the following:

    <ItemGroup>
      <DotNetCliToolReference Include="Microsoft.DotNet.Watcher.Tools" Version="2.0.0" />
    </ItemGroup>

2. Open the Startup.cs file

Add 

    app.UseDefaultFiles(); 
    app.UseStaticFiles();

to Configure method

        public void Configure(IApplicationBuilder app, IHostingEnvironment env)
        {
            app.UseDefaultFiles();
            app.UseStaticFiles();
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseMvc();
        }


## Configure the Angular Application

1. Open the .angular-cli.json file

When the Angular-CLI to builds the application, it has to output the assets to the /wwwroot directory — the same directory we configured ASP.NET Core to serve static files from.


    "apps": [
        {
          "root": "src",
          "outDir": "wwwroot",
          "assets": [
            "assets",
            "favicon.ico"
          ],
    

## Developer-Friendly Enhancements

Next, let’s simplify the development process by enabling both the Angular application and the ASP.NET Core application to rebuild whenever you make a change to its respective code.

1. Proxy your API calls to the ASP.NET Core Server

During development, we should use the ng serve command which watches for changes to your Angular code, transpiles the TypeScript code, and re-serves it to localhost:4200, by default.
Since your Angular application is being served on a different port than the API, it will send requests to localhost:4200/api instead of our API which is running on localhost:5000, by default.
To achieve this, we need to create a proxy.config.json file.

Add the following to your proxy.config.json:

    {
        "/api": {
           "target": "http://localhost:5000",
           "secure": false
        }
    }

## Restore packages

    cd AspCoreNgCli
    dotnet restore
    npm i
    cd ..

## Run application in watch mode

    cd AspCoreNgCli
    start dotnet watch run
    start ng serve --proxy-config proxy.config.json
    cd ..

Rererences

[1]. https://medium.com/@levifuller/building-an-angular-application-with-asp-net-core-in-visual-studio-2017-visualized-f4b163830eaa

[2]. https://www.infopulse.com/blog/tutorial-creating-basic-asp-net-core-angular-4-application-in-windows-10/

