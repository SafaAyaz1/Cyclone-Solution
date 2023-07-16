public class WidgetScheduledJob implements Schedulable {
    public void execute(SchedulableContext sc) {
        List<Widget__c> newWidgets = [SELECT Id, Value__c, OwnerId, Is_Properly_Nested__c FROM Widget__c WHERE CreatedDate >= :DateTime.now().addHours(-1) AND Is_Properly_Nested__c = null];

        List<Widget__c> widgetsToUpdate = new List<Widget__c>();
        List<Messaging.SingleEmailMessage> emailsToSend = new List<Messaging.SingleEmailMessage>();

        for (Widget__c widget : newWidgets) {
            if (NestingCheckerUtility.isProperlyNested(widget.Value__c)) {
                widget.Is_Properly_Nested__c = true;
            } else {
                widget.Is_Properly_Nested__c = false;
                sendEmailToWidgetOwner(widget);
            }

            widgetsToUpdate.add(widget);
        }

        update widgetsToUpdate;
    }

    private void sendEmailToWidgetOwner(Widget__c widget) {
        User owner = [SELECT Email FROM User WHERE Id = :widget.OwnerId];

        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(new List<String>{ owner.Email });
        email.setSubject('Improperly Nested Widget');
        email.setPlainTextBody('The value of the widget with ID: ' + widget.Id + ' is improperly nested.');

        Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{ email });
    }
}