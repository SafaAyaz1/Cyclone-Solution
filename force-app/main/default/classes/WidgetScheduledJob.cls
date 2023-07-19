public class WidgetScheduledJob implements Schedulable {

    // This method is executed when the scheduled job is run.
    public void execute(SchedulableContext sc) {
        // Retrieve new Widgets created within the last hour with 'Is_Properly_Nested__c' field set to null
        List<Widget__c> newWidgets = [SELECT Id, Value__c, OwnerId, Is_Properly_Nested__c FROM Widget__c WHERE CreatedDate >= :DateTime.now().addHours(-1) AND Is_Properly_Nested__c = null];

        List<Widget__c> widgetsToUpdate = new List<Widget__c>();
        List<Messaging.SingleEmailMessage> emailsToSend = new List<Messaging.SingleEmailMessage>();

        // Loop through each new Widget to check if it is properly nested and update the 'Is_Properly_Nested__c' field accordingly
        for (Widget__c widget : newWidgets) {
            if (NestingCheckerUtility.isProperlyNested(widget.Value__c)) {
                widget.Is_Properly_Nested__c = true;
            } else {
                widget.Is_Properly_Nested__c = false;
                sendEmailToWidgetOwner(widget); // Send an email to the Widget's owner if it is not properly nested
            }

            widgetsToUpdate.add(widget);
        }

        // Update the 'Is_Properly_Nested__c' field for the affected Widgets
        update widgetsToUpdate;
    }

    // Private helper method to send an email to the Widget's owner if it is not properly nested
    private void sendEmailToWidgetOwner(Widget__c widget) {
        // Retrieve the owner's email address from the User object
        User owner = [SELECT Email FROM User WHERE Id = :widget.OwnerId];

        // Compose the email message
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(new List<String>{ owner.Email });
        email.setSubject('Improperly Nested Widget');
        email.setPlainTextBody('The value of the widget with ID: ' + widget.Id + ' is improperly nested.');

        // Send the email
        Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{ email });
    }
}
