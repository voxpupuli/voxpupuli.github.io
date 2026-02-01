---
layout: post
title: Getting Started with OpenVoxDB Development
date: 2026-01-30
github_username: austb
---

Welcome to OpenVoxDB development. We recently added a helper script called
`ovdb` that makes local development much easier. This post covers how to get
started.

## What is OpenVoxDB?

OpenVoxDB is a database for OpenVox run information. It stores OpenVox-generated
data in PostgreSQL and exposes a query API. This dependency on PostgreSQL makes
OpenVoxDB slightly harder to start development on than OpenVox or
OpenVox-Server, which don't generally have external dependencies to configure.

## The `ovdb` Helper Script

Setting up a local OpenVoxDB instance usually means initializing Postgres,
configuring databases and configuring OpenVoxDB to connect to your Postgres.
The project contains many standalone scripts for automating these operations.
The `ovdb` script handles knowing how to invoke each script for you for the
most common development workflows.

It can:
- Initialize and manage Postgres sandboxes
- Run unit, parallel, and integration tests
- Start and stop services
- Manage multiple environments

## Prerequisites

You'll need:
- PostgreSQL 16+
- Java 17+
- Leiningen
- [pgbox](https://gitlab.com/pgbox-org/pgbox) (added to your PATH)

## Getting Started

### Step 1: Configure PostgreSQL Location

Copy the example config file:
```bash
cp dev-resources/ovdb.conf.example .ovdb.conf
```

Edit `.ovdb.conf` and set `pg_bin` to your PostgreSQL bin directory. Common paths:

**macOS (Homebrew)**
```bash
pg_bin=/opt/homebrew/opt/postgresql@17/bin
```

**macOS (Postgres.app)**
```bash
pg_bin=/Applications/Postgres.app/Contents/Versions/17/bin
```

**Linux (Debian/Ubuntu)**
```bash
pg_bin=/usr/lib/postgresql/17/bin
```

**Linux (RHEL/CentOS)**
```bash
pg_bin=/usr/pgsql-17/bin
```

Not sure where yours is? You can often find it by running `which psql`.

### Step 2: Verify Configuration

Run the doctor command to check your setup:
```bash
./ovdb doctor
```

This validates that `pg_bin` points to Postgres and checks that your sandbox
directory is writable.

### Step 3: Initialize the Database

Now, set up your Postgres sandbox and create the OpenVoxDB database:

```bash
./ovdb init
```

This command:
1. Creates a Postgres sandbox in `dev-resources/sandboxes/tmp_pg`
2. Initializes the database and roles
3. Installs necessary Postgres extensions
4. Writes the configuration files needed to connect OpenVoxDB to the newly
   created Postgres sandbox
5. Starts the Postgres server

### Step 4: Run OpenVoxDB

Start the application:

```bash
./ovdb run
```

OpenVoxDB will start and listen on `http://localhost:8080`.

## Running Tests

Testing is crucial for maintaining code quality. The `ovdb` script makes it
easy to run different test suites.

### Unit Tests

Run the complete unit test suite:

```bash
./ovdb test
```

To run a specific test:

```bash
./ovdb test :only puppetlabs.puppetdb.scf.migrate-test/some-test
```

Unit tests verify individual functions and components without requiring other
OpenVox projects.

### Integration Tests

Test OpenVoxDB's interaction with OpenVox and OpenVox-Server:

```bash
./ovdb integration
```

Integration tests clone and configure the OpenVox and OpenVox-Server
repositories, then run tests that exercise the full catalog compilation
process. This is more comprehensive (and slower) than unit tests, but often
catches compatibility issues between the three projects.

### External Tests

Test the built uberjar (packaged application) to verify CLI argument handling,
database migrations, error handling, and upgrade paths:

```bash
lein uberjar
./ovdb ext
```

## Working with Multiple Environments

Sometimes you need multiple sandboxes—perhaps for testing against different
Postgres versions or keeping separate test data. The `--name` flag lets you
create and manage multiple environments:

```bash
# Configure multiple pg versions in .ovdb.conf
pg_bin_17=/usr/lib/postgresql/17/bin
pg_bin_18=/usr/lib/postgresql/18/bin
```

```bash
# Create sandboxes for each pg 17 & 18
./ovdb --name pg-17-test --pgver 17 init
./ovdb --name pg-18-test --pgver 18 init

# Run against that sandbox
./ovdb --name pg-18-test run

# Switch to running against postgres 17
./ovdb --name pg-17-test run

# Run tests against pg18
./ovdb --name pg-18-test test
```

Each named sandbox is isolated and maintains its own database and configuration.
Postgres configurations are initialized with random ports so you can leave
multiple running and just swap between which `name` you reference for running
or testing OpenVoxDB.

## Troubleshooting

### "pg_bin is not configured"

**Solution**: Edit `.ovdb.conf` and ensure `pg_bin` points to your Postgres
bin directory. Run `./ovdb doctor` to verify.

### "pg_ctl not found"

**Solution**: Your `pg_bin` path is incorrect. Verify it contains:
- `pg_ctl`
- `psql`
- Other Postgres binaries

Run `ls $pg_bin` to check.

### "Cannot connect to database"

**Solution**: Ensure the Postgres server is running:
```bash
./ovdb start
```

If it still fails, check the logs:
```bash
./ovdb pglog
```

### Debugging Issues

If you are debugging issues with Postgres you can see the logs of the sandbox
with:
```bash
./ovdb pglog
```

## Next Steps

OpenVoxDB is a complicated project, but you should be ready to start developing
with the processes outlined in this post. There are still more commands that
you might find useful. There is `ptest` to run unit tests in parallel,
`benchmark` for populating your sandbox with test data, and `query` for running
PQL queries against a running OpenVoxDB. Run `./ovdb --help` to see all
available commands.

The `ovdb` script has been my personal tool to develop against this codebase
for many years. It is likely to have some rough edges that I just never
encounter, so please suggest any improvements you think would help you.
