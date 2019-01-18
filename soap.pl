#!/usr/bin/perl -w

#simpel perl program that sends SOAP request to specified server and prints response to stdout

use strict;
use LWP::UserAgent;
use HTTP::Request;

my $message = '<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:packetfront_becs">
   <soapenv:Header>
      <request xsi:type="urn:requestHeader" xmlns="urn:packetfront_becs">
         <!--You may enter the following 2 items in any order-->
         <sessionid xsi:type="xsd:string">bfcf07404533cf7c76d7df9619971966</sessionid>
      </request>
   </soapenv:Header>
   <soapenv:Body>
      <urn:bbeLogin soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
         <in xsi:type="urn:bbeLoginIn">
            <!--You may enter the following 2 items in any order-->
            <username xsi:type="xsd:string">abc</username>
            <password xsi:type="xsd:string">qwerty</password>
         </in>
      </urn:bbeLogin>
   </soapenv:Body>
</soapenv:Envelope>';

print "Message:\n",$message,"\n";

my $userAgent = LWP::UserAgent->new();
my $request = HTTP::Request->new(POST => 'http://1.2.3.4:4444'); 
$request->content($message);
$request->content_type("text/xml; charset=utf-8");
my $response = $userAgent->request($request);

if($response->code == 200) {
	print $response->as_string;
}
else {
	print $response->error_as_HTML;
}
