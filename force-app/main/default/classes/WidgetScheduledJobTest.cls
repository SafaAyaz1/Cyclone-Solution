@IsTest
private class WidgetScheduledJobTest {
    @IsTest
    static void testScheduledJob() {
        // Create test data: Widget with properly nested value
        Widget__c widget1 = new Widget__c(Value__c = '(ABC[123{XYZ}])');
        insert widget1;

        // Create test data: Widget with improperly nested value
        Widget__c widget2 = new Widget__c(Value__c = '(ABC[123{XYZ])]');
        insert widget2;

        // Schedule the job
        Test.startTest();
        String cronExp = '0 0 * * * ?'; // Every hour
        System.schedule('WidgetScheduledJobTest', cronExp, new WidgetScheduledJob());

        Test.stopTest();

        // Verify the results
        Widget__c updatedWidget1 = [SELECT Is_Properly_Nested__c FROM Widget__c WHERE Id = :widget1.Id];
        System.assertEquals(true, updatedWidget1.Is_Properly_Nested__c, 'Expected widget1 to be properly nested');

        Widget__c updatedWidget2 = [SELECT Is_Properly_Nested__c FROM Widget__c WHERE Id = :widget2.Id];
        System.assertEquals(false, updatedWidget2.Is_Properly_Nested__c, 'Expected widget2 to be improperly nested');

        // Assert that an email is sent for widget2
        // Write additional assertions for email sending if applicable
    }
}