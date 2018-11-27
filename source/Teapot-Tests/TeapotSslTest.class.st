Class {
	#name : #TeapotSslTest,
	#superclass : #TestCase,
	#instVars : [
		'teapot'
	],
	#category : #'Teapot-Tests'
}

{ #category : #private }
TeapotSslTest >> pemContent [
	^ String streamContents: [ :stream | 
		{
'-----BEGIN CERTIFICATE-----'.
'MIICAzCCAWwCCQDqdNQzO71rWzANBgkqhkiG9w0BAQUFADBFMQswCQYDVQQGEwJB'.
'VTETMBEGA1UECBMKU29tZS1TdGF0ZTEhMB8GA1UEChMYSW50ZXJuZXQgV2lkZ2l0'.
'cyBQdHkgTHRkMCAXDTE3MDYyNDA4MDM1OVoYDzIxMTcwNTMxMDgwMzU5WjBFMQsw'.
'CQYDVQQGEwJBVTETMBEGA1UECBMKU29tZS1TdGF0ZTEhMB8GA1UEChMYSW50ZXJu'.
'ZXQgV2lkZ2l0cyBQdHkgTHRkMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDk'.
'ysKeTfdTjx0l573Ag4ITy80env0TfKGdyjlHkehuzQBQsg+DiyQs2Ckr9GaaZIOe'.
'BW/6btvHG51aGG+Fz2WtHY4MetyLJ/zy5PlzjOeGvRwAUwla0JZX8fB8poKgNXkm'.
'gVeuCA3PKPnE6Ba1ucofvdtIsDMqpbABLMxdjhvagQIDAQABMA0GCSqGSIb3DQEB'.
'BQUAA4GBAEf6vsOCHtWJT760Wdm606TWpY+EbxKdXViEtWaDT0K91HBrGqBnSvgC'.
'1ByDRKz1L3UyfUjgaP04Iuy3aAUtUZ188A4YfC1XLcYln3K/3NNP4+S272R09Nne'.
'kV7vvJt4I8vubjEo3Ihassy4PVTwcf6JnUBIdK7p4k+yAupHjzof'.
'-----END CERTIFICATE-----'.
'-----BEGIN RSA PRIVATE KEY-----'.
'MIICXQIBAAKBgQDkysKeTfdTjx0l573Ag4ITy80env0TfKGdyjlHkehuzQBQsg+D'.
'iyQs2Ckr9GaaZIOeBW/6btvHG51aGG+Fz2WtHY4MetyLJ/zy5PlzjOeGvRwAUwla'.
'0JZX8fB8poKgNXkmgVeuCA3PKPnE6Ba1ucofvdtIsDMqpbABLMxdjhvagQIDAQAB'.
'AoGAG501XDIA1f8B/5820dONkaIZgcaiuQVj5E2SGEdODIGFtjenk7LpjNgSMBHx'.
'iFT1Zc82Mr3KnP+CQGuOmlHr7XylvmFM29x/cLd4HSvZNdg6pMrzuv/ILC27GLfU'.
'gDGAVmyeBiyMTOLk6TJ/LElIrt+HABaHaa43XH/mF3VjAoECQQDzc3aDXCOOBvlA'.
'mV3TgMEIuP9vEq5dgdz7bYZSVutc605AYo/1c9TkmlMy722/abQm0IpT1XRNjTmc'.
'HT+Y5gb5AkEA8JXcGS9T0L5Vl2cel9wiad5oNbLGfG17nQQUl3LXikfPrcBGDmD4'.
'aoEZkScPx3gKfawwKw8wsUwus30aWZapyQJBAJ5IqftKQsuq+Q/pJznGcrsrHNio'.
'urmNH5JRaY3LeYeWbfAqpRKfVwGy3Pk29pIHNdwupmFPXSi284fu9FSC6nECQQDV'.
'w+IPwpyPcj7syuRE/ITbWpFvfQydjE30YqbFNnZLWKkv8hKNPh4by9/iuDlt+7we'.
'k/ssl0+liVJJixP5nEP5AkB8dFXPvAsxeTHCPMwAsJlPnxRodktuY7SlEUqqEpex'.
'yxwciD3/Fyai686sj5iYiOuy2xcxaFZvJ1K1J/aCvwhK'.
'-----END RSA PRIVATE KEY-----'.
} do: [ :line | stream nextPutAll: line; crlf ]
]
]

{ #category : #private }
TeapotSslTest >> pemFile [
	^ FileLocator temp asFileReference / 'test-teapot-ssl.pem'
]

{ #category : #initialization }
TeapotSslTest >> setUp [
	self writeOutPemTo: self pemFile.
	teapot := Teapot configure: { 
		#znServer -> (
			(ZnSecureServer on: 1443) 
				certificate: self pemFile fullName;
				yourself).
	}.
	teapot
		GET: '/ssl' -> 'secure';
		start.
]

{ #category : #running }
TeapotSslTest >> tearDown [
	teapot stop.
	self pemFile delete.
]

{ #category : #tests }
TeapotSslTest >> testHttpsGet [
	self skip.
	"| result |
	result := ZnEasy get: 'https://localhost:1443/ssl'.
	self assert: result equals: 'secure'."
]

{ #category : #private }
TeapotSslTest >> writeOutPemTo: aFileReference [
	aFileReference writeStreamDo: [ :stream | stream nextPutAll: self pemContent ]
]
