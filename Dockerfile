#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/sdk:6.0-focal AS build
WORKDIR /source

# copy csproj and restore dependencies
COPY *.csproj ./
RUN dotnet restore

# copy and publish app and libraries
COPY . .
# RUN dotnet add package Lightrun --version 1.9.0-alpha1
RUN dotnet add package Lightrun --version 1.10.0-beta.1
RUN dotnet publish -c debug -o /app --self-contained false --no-restore

# final stage/image
FROM mcr.microsoft.com/dotnet/runtime:6.0-focal AS publish
RUN apt-get update && apt-get install -y libunwind8
WORKDIR /app
COPY --from=build /app .
# debug
COPY --from=build /source /source 

# default entry point and command argument
#ENTRYPOINT ["./PrimeCSharp"]
#CMD ["--demo"]

