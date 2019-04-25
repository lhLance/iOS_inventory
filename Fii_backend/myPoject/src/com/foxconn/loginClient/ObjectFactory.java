
package com.foxconn.loginClient;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlElementDecl;
import javax.xml.bind.annotation.XmlRegistry;
import javax.xml.namespace.QName;

/**
 * This object contains factory methods for each Java content interface and Java
 * element interface generated in the com.foxcoon.loginClient package.
 * <p>
 * An ObjectFactory allows you to programatically construct new instances of the
 * Java representation for XML content. The Java representation of XML content
 * can consist of schema derived interfaces and classes representing the binding
 * of schema type definitions, element declarations and model groups. Factory
 * methods for each of these are provided in this class.
 * 
 */
@XmlRegistry
public class ObjectFactory {

	private final static QName _RegisterResponse_QNAME = new QName("http://fun.foxcoon.com/", "registerResponse");
	private final static QName _CheckLogin_QNAME = new QName("http://fun.foxcoon.com/", "checkLogin");
	private final static QName _CheckLoginResponse_QNAME = new QName("http://fun.foxcoon.com/", "checkLoginResponse");
	private final static QName _Register_QNAME = new QName("http://fun.foxcoon.com/", "register");

	/**
	 * Create a new ObjectFactory that can be used to create new instances of
	 * schema derived classes for package: com.foxcoon.loginClient
	 * 
	 */
	public ObjectFactory() {
	}

	/**
	 * Create an instance of {@link CheckLogin }
	 * 
	 */
	public CheckLogin createCheckLogin() {
		return new CheckLogin();
	}

	/**
	 * Create an instance of {@link Register }
	 * 
	 */
	public Register createRegister() {
		return new Register();
	}

	/**
	 * Create an instance of {@link RegisterResponse }
	 * 
	 */
	public RegisterResponse createRegisterResponse() {
		return new RegisterResponse();
	}

	/**
	 * Create an instance of {@link CheckLoginResponse }
	 * 
	 */
	public CheckLoginResponse createCheckLoginResponse() {
		return new CheckLoginResponse();
	}

	/**
	 * Create an instance of {@link JAXBElement }{@code <}
	 * {@link RegisterResponse }{@code >}}
	 * 
	 */
	@XmlElementDecl(namespace = "http://fun.foxcoon.com/", name = "registerResponse")
	public JAXBElement<RegisterResponse> createRegisterResponse(RegisterResponse value) {
		return new JAXBElement<RegisterResponse>(_RegisterResponse_QNAME, RegisterResponse.class, null, value);
	}

	/**
	 * Create an instance of {@link JAXBElement }{@code <}{@link CheckLogin }
	 * {@code >}}
	 * 
	 */
	@XmlElementDecl(namespace = "http://fun.foxcoon.com/", name = "checkLogin")
	public JAXBElement<CheckLogin> createCheckLogin(CheckLogin value) {
		return new JAXBElement<CheckLogin>(_CheckLogin_QNAME, CheckLogin.class, null, value);
	}

	/**
	 * Create an instance of {@link JAXBElement }{@code <}
	 * {@link CheckLoginResponse }{@code >}}
	 * 
	 */
	@XmlElementDecl(namespace = "http://fun.foxcoon.com/", name = "checkLoginResponse")
	public JAXBElement<CheckLoginResponse> createCheckLoginResponse(CheckLoginResponse value) {
		return new JAXBElement<CheckLoginResponse>(_CheckLoginResponse_QNAME, CheckLoginResponse.class, null, value);
	}

	/**
	 * Create an instance of {@link JAXBElement }{@code <}{@link Register }
	 * {@code >}}
	 * 
	 */
	@XmlElementDecl(namespace = "http://fun.foxcoon.com/", name = "register")
	public JAXBElement<Register> createRegister(Register value) {
		return new JAXBElement<Register>(_Register_QNAME, Register.class, null, value);
	}

}
