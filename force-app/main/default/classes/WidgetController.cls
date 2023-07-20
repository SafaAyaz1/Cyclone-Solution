public class WidgetController {
    @AuraEnabled
    public static void saveWidget(String widgetValue) {
        try {
            Widget__c newWidget = new Widget__c(Value__c = widgetValue);
            insert newWidget;
        } catch (Exception ex) {
            throw new AuraHandledException('Error saving widget: ' + ex.getMessage());
        }
    }
}