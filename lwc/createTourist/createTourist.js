import {LightningElement, track } from 'lwc';
import submitScoreAction from '@salesforce/apex/createTourist.submitScoreAction';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import {NavigationMixin} from 'lightning/navigation';

export default class insertRecordCustomObjectLwc extends NavigationMixin (LightningElement) {

    @track scoreObName;
    @track scoreObjBirthday;
    @track scoreObjEmail;

    get options() {
      return[
      {value: 'male', label: 'Male'},
      {value: 'female', label: 'Female'},
      {value: 'unknown', label: 'Unknown'}
      ] ;
   }

   scoreHandleChange(event){
        if (event.target.name == 'scoreName') {
        this.scoreObName = event.target.value;  
        }
      if (event.target.name == 'scoreBirthday') {
        this.scoreObjBirthday = event.target.value;  
      }
      if (event.target.name == 'scoreEmail') {
        this.scoreObjEmail = event.target.value;  
    }

}

handleChange(event) {
  this.value = event.target.value;
}

 submitAction(){
    submitScoreAction({cardName:this.scoreObName,cardBirthday:this.scoreObjBirthday, cardEmail:this.scoreObjEmail, cardGender:this.value})
    .then(result => {
        this.scoreRecoreId = result.Id;
        window.console.log('scoreRecoreId##Vijay2 ' + this.scoreRecoreId);       
        const toastEvent = new ShowToastEvent({
            title:'Success!',
            message:'Record created successfully',
            variant:'success'
          });
          this.dispatchEvent(toastEvent);

          this[NavigationMixin.GenerateUrl]({
            type: 'standard__webPage',
            attributes: {
                url: 'https://diseven-developer-edition.ap24.force.com/test/s/?id=' + this.scoreRecoreId
            },
         }).then(generatedUrl => {
          window.open(generatedUrl);
      });
         ;
    })
    .catch(error =>{
       this.errorMsg=error.message;
       window.console.log(this.error);
    });

 }
}
