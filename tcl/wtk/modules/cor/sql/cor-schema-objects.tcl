
# create cordb schema

<< Class ::wtk::cor::SQLComponent \
    -ObjNameFormat COR_SQLCMP%03i \
    -ObjCounter 0 \
    -VARIABLES {
        {name {{}} - {::wtk::cor::checkStringLength name 64 1}}
        {abbrev "" - {}}
        {comments {{}} + {}}
    }\
    +METHODS getName\
    +METHODS getAbbrev\
    +METHODS getComments\
>>

<< ::wtk::cor::SQLComponent.method getName {} {
    variable name
    return $name
} PUBLIC >>

<< ::wtk::cor::SQLComponent.method getAbbrev {} {
    variable abbrev
    return $abbrev
} PUBLIC >>

<< ::wtk::cor::SQLComponent.method getComments {} {
    variable comments
    return $comments
} PUBLIC >>


<< Class ::wtk::cor::Schema +Public ::wtk::cor::SQLComponent
    -ObjNameFormat COR_SCHEMA%03i \
    -ObjCounter 0 \
    -VARIABLES {
    }\
>>


<< Class ::wtk::cor::Module +Public ::wtk::cor::SQLComponent\
    -ObjNameFormat COR_MODULE%03i \
    -ObjCounter 0 \
    -VARIABLES {
    }\
>>

set schema [<< ::wtk::cor::Schema -name mySchema -abbrev mys \
    +comments "This is my first schema" >>]

::wtk::log::log Notice "Schema name is '[<< $schema.getName >>]'"