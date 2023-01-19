// ***********************************************
// This example commands.js shows you how to
// create various custom commands and overwrite
// existing commands.
//
// For more comprehensive examples of custom
// commands please read more here:
// https://on.cypress.io/custom-commands
// ***********************************************
//
//
// -- This is a parent command --
// Cypress.Commands.add('login', (email, password) => { ... })
//
//
// -- This is a child command --
// Cypress.Commands.add('drag', { prevSubject: 'element'}, (subject, options) => { ... })
//
//
// -- This is a dual command --
// Cypress.Commands.add('dismiss', { prevSubject: 'optional'}, (subject, options) => { ... })
//
//
// -- This will overwrite an existing command --
// Cypress.Commands.overwrite('visit', (originalFn, url, options) => { ... })

Cypress.on('uncaught:exception', (err, runnable) => {
    // returning false here prevents Cypress from failing the test
    return false
  })

export class cypress{

    signup_icon = '[href="/users/new"]'
    email_textbox = '#user_email'
    username_textbox = '#user_fullname'
    password_textbox = '#user_password'
    submit_button = '.form-submit'
    signin_icon = '[href="/users/login"]'
    click_createproject = '[href="/users/projects/create"]'
    title_textbox = '#project_title'
    description_textbox = '#project_description'
    edit_titlebox = '#project_title'
    edit_descriptionbox = '#project_description'
    edit_icon = '[title="Edit Project Details"] > .fa'
    delete_icon = '.btn-danger > .fa'
    logout_icon = '.list-group > [href="/users/logout"]'
    click_dashboard = '.right > [href="/users/dashboard"]'
    click_profile = '[href="/users/profile"]'

    clickSignup(){
        cy.get(this.signup_icon).click()
    }

    enterEmailAddress(email){
        cy.get(this.email_textbox).type(email)
    }

    enterUsername(username){
        cy.get(this.username_textbox).type(username)
    }

    enterPassword(){
        const password = Cypress.env('password');
        cy.get(this.password_textbox).type(password)
    }

    enterinvalidPassword(invalidpass){
        cy.get(this.password_textbox).type(invalidpass)
    }

    clickSubmit(){
        cy.get(this.submit_button).click()
    }

    clickSignin(){
        cy.get(this.signin_icon).click()
    }
    
    clickdashboard(){
        cy.get(this.click_dashboard).click()
    }

    clickprofile(){
        cy.get(this.click_profile).click()
    }

    clickcreateproject(){
        cy.get(this.click_createproject).click()
    }

    enterprojecttitle(Title){
        cy.get(this.title_textbox).type(Title)
    }

    enterdescription(Description){
        cy.get(this.description_textbox).type(Description)
    }

    editicon(){
        cy.get(this.edit_icon).click()
    }

    editdescription(){
        cy.get('textarea').clear()
        cy.get(this.edit_descriptionbox).type('Learning cypress')
    }

    clickdelete(){
        cy.get(this.delete_icon).click()
    }

    clicklogout(){
        cy.get(this.logout_icon).click()
    }

    dashboardverification(){
        cy.get('h3').contains('Welcome, Cypress_learning')
    }

    profileverification(){
        cy.get('h3').contains('Profile Page')
    }

    invalidemailverification(){
        cy.get(class{'alert alert-danger'}).contains('Incorrect Email Provided')
    }

    invalidpasswordverification(){
        cy.get(class{'alert alert-danger'}).contains('Incorrect Password Provided')
    }

    
}
