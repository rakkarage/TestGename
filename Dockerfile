FROM microsoft/dotnet:sdk AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY ./TestGename.sln ./
COPY ./TestGename/TestGename.csproj ./TestGename/
COPY ./Gename/Gename.csproj ./Gename/
RUN dotnet restore ./TestGename/TestGename.csproj

# Copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o out

# Build runtime image
FROM microsoft/dotnet:aspnetcore-runtime
WORKDIR /app
COPY --from=build-env /app/TestGename/out .
ENTRYPOINT ["dotnet", "TestGename.dll"]
