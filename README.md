JTJSON

Do we really need a third party JSON parsing library?
Can we achieve it by having simple characters substitution on a JSON response to transform it into a plist string
, then we can use NSPropertySerialization to convert it to an NSDictionary or NSArray.

This is just an experimental project to find it out. If it's possible, how much effort is needed and what's the performance comparing to other libraries?

-
James
