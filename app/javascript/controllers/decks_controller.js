import { Controller } from "stimulus"

export default class extends Controller {
    static targets = ["branch", "add", "show"]
    
    addBranch() {
        let content = this.branchTarget.value;
        this.addTarget.insertAdjacentHTML('beforebegin', "<li>" + content + "</li>");
    }

}