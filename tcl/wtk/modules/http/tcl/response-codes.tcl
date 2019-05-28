# HTTP Response Codes and description map

namespace eval ::wtk::http {

    variable Codes {
        {200 OK}
        {201 Created}
        {202 Accepted}
        {203 {Partial Information}}
        {204 {No Response}}
        {301 Moved}
        {302 Found}
        {303 Method}
        {304 {Not Modified}}
        {400 {Bad Request}}
        {401 Unauthorized}
        {402 {Payment Required}}
        {403 Forbidden}
        {404 {Not Found}}
        {500 {Internal Server Error}}
        {501 {Not Implemented}}
        {502 {Service Temporarily Overloaded}}
        {503 {Gateway Timeout}}
    }

    variable HttpResponseCodes [::wtk::nv::create HttpResponseCodes $Codes]
}

proc ::wtk::http::getResponseCodeDescription { code } {

    variable HttpResponseCodes

    nvGet HttpResponseCodes $code
}
