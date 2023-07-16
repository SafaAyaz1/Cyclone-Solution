import { LightningElement, track, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { getRecord } from 'lightning/uiRecordApi';
import saveWidget from '@salesforce/apex/WidgetController.saveWidget';

export default class WidgetInputForm extends LightningElement {
    @track widgetValue = '';
    @track disableSaveButton = true;
    @track showValidationMessage = false;
    @track validationMessage = '';
    @track isSystemAdmin = false;

    @wire(getRecord, { recordId: '$currentUserId', fields: ['User.Profile.Name'] })
    currentUser;

    get currentUserId() {
        return this.currentUser.data ? this.currentUser.data.fields.Id.value : null;
    }

    get isSaveDisabled() {
        return this.disableSaveButton || (!this.isSystemAdmin && !this.isWidgetValueValid());
    }

    handleInputChange(event) {
        this.widgetValue = event.target.value;
        this.disableSaveButton = !this.isWidgetValueValid();
        this.showValidationMessage = false;
    }

    isWidgetValueValid() {
        // Get the widget value
        const value = this.widgetValue.trim();
    
        // Stack to track opening symbols
        const stack = [];
    
        // Iterate through each character in the value
        for (let i = 0; i < value.length; i++) {
            const char = value[i];
    
            if (char === '(' || char === '[' || char === '{') {
                // Push opening symbols onto the stack
                stack.push(char);
            } else if (char === ')' || char === ']' || char === '}') {
                // Check if there is a matching opening symbol
                if (stack.length === 0) {
                    return false;
                }
    
                const lastOpeningSymbol = stack.pop();
    
                // Check if the opening and closing symbols match
                if (
                    (lastOpeningSymbol === '(' && char !== ')') ||
                    (lastOpeningSymbol === '[' && char !== ']') ||
                    (lastOpeningSymbol === '{' && char !== '}')
                ) {
                    return false;
                }
            }
        }
    
        // Return true if the stack is empty (all opening symbols have been closed)
        return stack.length === 0;
    }
    

    handleSaveWidget() {
        if (this.isWidgetValueValid() || this.isSystemAdmin) {
            saveWidget({ widgetValue: this.widgetValue })
                .then(result => {
                    // Show success toast message
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success',
                            message: 'Widget saved successfully',
                            variant: 'success'
                        })
                    );

                    // Reset the widget value
                    this.widgetValue = '';
                    this.disableSaveButton = true;
                })
                .catch(error => {
                    // Show error toast message
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Error',
                            message: 'Error saving widget',
                            variant: 'error'
                        })
                    );
                });
        } else {
            this.showValidationMessage = true;
            this.validationMessage = 'Widget value is not properly nested';
        }
    }
}