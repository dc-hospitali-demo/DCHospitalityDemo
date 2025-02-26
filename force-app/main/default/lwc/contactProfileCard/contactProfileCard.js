import { LightningElement, api, wire ,track} from 'lwc';
import { getRecord, getFieldValue} from 'lightning/uiRecordApi';

import NAME_FIELD from '@salesforce/schema/Contact.Name';
import MAILING_CITY_FIELD from '@salesforce/schema/Contact.MailingCity';
import MAILING_STATE_FIELD from '@salesforce/schema/Contact.MailingState';
import MAILING_POSTAL_CODE from '@salesforce/schema/Contact.MailingPostalCode';
import MAILING_STREET from '@salesforce/schema/Contact.MailingStreet';
import PHOTO_URL_FIELD from '@salesforce/schema/Contact.Photo_URL__c';
import { getRelatedListRecords } from 'lightning/uiRelatedListApi';
import getExperienceType from '@salesforce/apex/ContactProfileCardDetails.getExperienceType';

const fields = [
    NAME_FIELD,
    MAILING_CITY_FIELD,
    MAILING_STATE_FIELD,
    MAILING_POSTAL_CODE,
    MAILING_STREET,
    PHOTO_URL_FIELD
];

export default class ContactProfileCard extends LightningElement {
    @api recordId;
    @track error;

    @wire(getRecord, { recordId: '$recordId', fields })
    contact;

    get hasData() {
        return this.contact?.data !== undefined;
    }

    get error() {
        return this.contact?.error;
    }

    get name() {
        return getFieldValue(this.contact.data, NAME_FIELD);
    }

    get mailingCity() {
        return getFieldValue(this.contact.data, MAILING_CITY_FIELD);
    }

    get mailingState() {
        return getFieldValue(this.contact.data, MAILING_STATE_FIELD);
    }

    get mailingPostalCode() {
        return getFieldValue(this.contact.data, MAILING_POSTAL_CODE);
    }

    get mailingStreet() {
        return getFieldValue(this.contact.data, MAILING_STREET);
    }
    get photoURL() {
        const photoURL = getFieldValue(this.contact.data, PHOTO_URL_FIELD);
        return photoURL
            ? photoURL
            : 'https://res.cloudinary.com/btahub/image/upload/v1708357811/ntbg5p1mwixury672dxy.png';
    }

    // Member Trait Changes Start
@wire(getExperienceType, {contactId: '$recordId'})
exprienceTypeValues({ error, data }){
    if(data){
        this.bookingExpierenceTypeValues = data;
        //this.spiltvalues = this.bookingExpierenceTypeValues.split(',');
       // console.log('spiltvalues',spiltvalues);
        console.log('booking:',data);
    }else if(error){
        this.error = error;
        console.log('error:',error);
    }
}
 // Member Trait Changes End
}