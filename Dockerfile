FROM mcr.microsoft.com/dotnet/sdk:6.0

# Install packages
WORKDIR /

RUN apt-get update
RUN apt-get install -y curl

RUN curl -fsSL https://deb.nodesource.com/setup_19.x | bash - &&\
apt-get install -y nodejs

# Copy app over
WORKDIR /app

COPY DotnetTemplate.Web/ /app/DotnetTemplate.Web
COPY DotnetTemplate.Web.Tests/ /app/DotnetTemplate.Web.Tests
COPY img/ /app/img
COPY DotnetTemplate.sln DotnetTemplate.sln.DotSettings /app/


# Build app
WORKDIR /app
RUN dotnet build

WORKDIR /app/DotnetTemplate.Web
RUN npm install
RUN npm run build


# Run tests
WORKDIR /app
RUN dotnet test

WORKDIR /app/DotnetTemplate.Web
RUN npm t


#Lint code
WORKDIR /app/DotnetTemplate.Web

RUN npm run lint


# Setup
EXPOSE 5000


#Run app
ENTRYPOINT dotnet run