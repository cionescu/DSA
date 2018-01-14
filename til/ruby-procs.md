## Ruby 2.3 added `to_proc`

`Hash#to_proc` returns a proc that takes a key a parameter and returns the matching value.

```ruby
a = {name: "Catalin", email: "cionescu@test.com", title: "Software Engineer"}
[:name, :title].map(&a)
```

> [ "Catalin", "Software Engineer" ]

Same as `Hash#slice`, just using procs. _NOTE_: `Hash#slice` will be added to [Ruby 2.5](https://wyeworks.com/blog/2017/12/28/new-features-in-ruby-2-dot-5-0)
