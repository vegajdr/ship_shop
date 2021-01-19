# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s
  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'ShipShop API V1',
        description: 'Documentation for online groceries shopping engine API',
        version: 'v1'
      },
      paths: {},
      servers: [
        {
          url: 'http://localhost:3000',
          description: 'Local Server'
        }
      ],
      tags: [
        {
          name: 'Location',
          description: <<~TEXT
            Representation of a location holding inventory (Stock)
          TEXT
        },
        {
          name: 'Stock',
          description: <<~TEXT
            Location Stock
          TEXT
        },
        {
          name: 'Product',
          description: <<~TEXT
            Known Product
          TEXT
        }
      ],
      components: {
        schemas: {
          product: {
            type: 'object',
            properties: {
              id: {
                type: 'integer',
                format: 'int64',
                example: 1
              },
              name: {
                type: 'string',
                example: 'Orange'
              },
              description: {
                type: 'string'
              },
              sku: {
                type: 'string',
                example: '12345'
              },
              price: {
                type: 'number',
                format: 'double',
                example: 1.50
              },
              quantity: {
                type: 'integer',
                format: 'int64',
                example: 5
              }
            }
          },
          new_product: {
            type: 'object',
            properties: {
              name: {
                type: 'string',
                example: 'Orange'
              },
              description: {
                type: 'string'
              },
              sku: {
                type: 'string',
                example: '12345'
              },
              price: {
                type: 'number',
                format: 'double',
                example: 1.50
              }
            }
          },
          location: {
            type: 'object',
            properties: {
              id: {
                type: 'integer',
                format: 'int64',
                example: 1
              },
              name: {
                type: 'string',
                example: 'Store #1'
              },
              description: {
                type: 'string',
                example: 'My first store'
              }
            }
          },
          new_location: {
            type: 'object',
            properties: {
              name: {
                type: 'string',
                example: 'Store #1'
              },
              description: {
                type: 'string',
                example: 'My first store'
              }
            }
          }
        }
      }
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml
end
