FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS base
WORKDIR /app
EXPOSE 8080
EXPOSE 8081

USER app
FROM --platform=$BUILDPLATFORM mcr.microsoft.com/dotnet/sdk:10.0 AS build
ARG configuration=Release
WORKDIR /src
COPY ["Minimal.TodoApi.csproj", "./"]
RUN dotnet restore "Minimal.TodoApi.csproj"
COPY . .
WORKDIR /src
RUN dotnet build "Minimal.TodoApi.csproj" -c $configuration -o /app/build

FROM build AS publish
ARG configuration=Release
RUN dotnet publish "Minimal.TodoApi.csproj" -c $configuration -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Minimal.TodoApi.dll"]

# build the image
# > docker build -t minimal-todo:v1

# Run the image
# docker run -it --rm -p 8080:8080 --name todo-app minimal-todoapi:v1
# -it: Runs in interactive mode so you can see the logs in your terminal.
# --rm: Automatically removes the container when you stop it (Ctrl+C).
# -p 8080:8080: Maps localhost:8080 to the container's port 8080.
# --name todo-app: Gives the container a friendly name.

# > docker container ls
# > docker container stop <container_name_or_id>

# For immediate force-stop (not recommended unles unresponsive), use 
# > docker kill <container_name_or_id>

# Pro Tip: "Hot Reload" in Docker
# The steps above run the compiled production version of your app. If by "hot run" you meant Hot Reload (where the app updates immediately when you save code changes), you need to run the SDK image directly and mount your source code.

# Run this command instead of the standard build/run flow:Pro Tip: "Hot Reload" in Docker
# The steps above run the compiled production version of your app. If by "hot run" you meant Hot Reload (where the app updates immediately when you save code changes), you need to run the SDK image directly and mount your source code.

# Run this command instead of the standard build/run flow:
# > docker run --rm -it -p 8080:8080 -v "%cd%:/app" -w /app mcr.microsoft.com/dotnet/sdk:10.0 dotnet watch run
