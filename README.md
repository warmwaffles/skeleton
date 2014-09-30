# Skeleton

Skeleton is a tool to help people construct `OPTIONS` api responses. This library
is simply a data structure with no ties to any one framework.

## Example

```ruby
skeleton = Skeleton.build do |config|
  config.define(:get, also: :head) do |action|
    action.description = 'Display a list of resources'

    action.param('limit') do |p|
      p.type = 'integer'
      p.description = 'The number of items desired'
      p.required = false
      p.restriction('Minimum value is 0')
      p.restriction('Maximum value is 9000')
    end

    action.param('offset') do |p|
      p.type = 'integer'
      p.description = 'The offset within the collection'
      p.required = false
      p.restriction('Minimum value is 0')
    end

    action.example do |e|
      e.param('limit', 10),
      e.param('offset', 0)
    end

    action.link(name: 'Self', rel: 'self', href: 'https://api.example.org/resources')
  end

  config.link(name: 'Documentation', rel: 'docs', href: 'https://docs.example.org/resources')
end

skeleton.to_h
```

Example `Skeleton::Builder#to_h` call

```ruby
{
  "links"=>[],
  "GET"=>{
    "description"=>"Display a list of resources",
    "parameters"=>{
      "limit"=>{
        "type"=>"integer",
        "description"=>"The number of items desired",
        "required"=>false,
        "allowed"=>[],
        "restrictions"=>[
          "Minimum value is 0",
          "Maximum value is 9000"
        ]
      },
      "offset"=>{
        "type"=>"integer",
        "description"=>"The offset within the collection",
        "required"=>false,
        "allowed"=>[],
        "restrictions"=>[
          "Minimum value is 0"
        ]
      }
    },
    "links"=>[
      {
        "name"=>"Self",
        "rel"=>"self",
        "href"=>"https://api.example.org/resources"
      }
    ],
    "examples"=>[
      {
        "limit"=>10,
        "offset"=>0
      }
    ]
  },
  "HEAD"=>{
    "description"=>"Display a list of resources",
    "parameters"=>{
      "limit"=>{
        "type"=>"integer",
        "description"=>"The number of items desired",
        "required"=>false,
        "allowed"=>[],
        "restrictions"=>[
          "Minimum value is 0",
          "Maximum value is 9000"
        ]
      },
      "offset"=>{
        "type"=>"integer",
        "description"=>"The offset within the collection",
        "required"=>false,
        "allowed"=>[],
        "restrictions"=>[
          "Minimum value is 0"
        ]
      }
    },
    "links"=>[
      {
        "name"=>"Self",
        "rel"=>"self",
        "href"=>"https://api.example.org/resources"
      }
    ],
    "examples"=>[
      {
        "limit"=>10,
        "offset"=>0
      }
    ]
  }
}
```
