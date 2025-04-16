#!/bin/bash
echo "Generating API & model interfaces from OpenAPI spec..."
mvn openapi-generator:generate
echo "Done. You can now run 'mvn compile'"