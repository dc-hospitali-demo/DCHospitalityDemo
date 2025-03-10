/**
 * @description       : THis is the Test class for WeatherService.
 * @date              : January 02, 2025
**/

@isTest
private class WeatherService_Test {
    @isTest
    static void getResortWeather_works() {
        // Set up test data
        Datetime dateToCheck = Datetime.newInstance(2024, 7, 14);

        // Set up mock HTTP response
        String mockResponse = '{"weather": [{"temperature": 10.0, "condition": "rain"},{"temperature": 30.0, "condition": "rain"}]}';
        Test.setMock(
            HttpCalloutMock.class,
            new MockHttpResponse(200, mockResponse)
        );

        // Call the method to be tested
        Test.startTest();
        WeatherService.Weather weather = WeatherService.getResortWeather(
            dateToCheck
        );
        Test.stopTest();

        // Assert the results
        Assert.areEqual(10.0, weather.minTemperatureC);
        Assert.areEqual(50.0, weather.minTemperatureF);
        Assert.areEqual(30.0, weather.maxTemperatureC);
        Assert.areEqual(86.0, weather.maxTemperatureF);
        Assert.areEqual(
            'On July 14, temperature should be between 10.0°C (50.0°F) and 30.0°C (86.0°F) and condition will be rain at Sunshine Trails Resorts.',
            weather.description
        );
    }

    @isTest
    static void getResortWeather_failsWithError() {
        // Set up mock HTTP response
        Test.setMock(HttpCalloutMock.class, new MockHttpResponse(404, ''));

        // Call the method to be tested
        Test.startTest();
        try {
            WeatherService.getResortWeather(Datetime.newInstance(2024, 7, 14));
            Assert.fail('Expected CalloutException');
        } catch (CalloutException e) {
            System.assert(e.getMessage().startsWith('Bad response'));
        }
        Test.stopTest();
    }

    private class MockHttpResponse implements HttpCalloutMock {
        private Integer statusCode;
        private String body;

        public MockHttpResponse(Integer statusCode, String body) {
            this.statusCode = statusCode;
            this.body = body;
        }

        public HttpResponse respond(HttpRequest request) {
            HttpResponse res = new HttpResponse();
            res.setBody(body);
            res.setStatusCode(statusCode);
            return res;
        }
    }
}