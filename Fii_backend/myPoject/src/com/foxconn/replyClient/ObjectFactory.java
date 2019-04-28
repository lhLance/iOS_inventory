
package com.foxconn.replyClient;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlElementDecl;
import javax.xml.bind.annotation.XmlRegistry;
import javax.xml.namespace.QName;

/**
 * This object contains factory methods for each Java content interface and Java
 * element interface generated in the com.foxcoon.replyClient package.
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

	private final static QName _GetReply_QNAME = new QName("http://inter.foxcoon.com/", "getReply");
	private final static QName _GetReplyResponse_QNAME = new QName("http://inter.foxcoon.com/", "getReplyResponse");

	/**
	 * Create a new ObjectFactory that can be used to create new instances of
	 * schema derived classes for package: com.foxcoon.replyClient
	 * 
	 */
	public ObjectFactory() {
	}

	/**
	 * Create an instance of {@link GetReply }
	 * 
	 */
	public GetReply createGetReply() {
		return new GetReply();
	}

	/**
	 * Create an instance of {@link GetReplyResponse }
	 * 
	 */
	public GetReplyResponse createGetReplyResponse() {
		return new GetReplyResponse();
	}

	/**
	 * Create an instance of {@link JAXBElement }{@code <}{@link GetReply }
	 * {@code >}}
	 * 
	 */
	@XmlElementDecl(namespace = "http://inter.foxcoon.com/", name = "getReply")
	public JAXBElement<GetReply> createGetReply(GetReply value) {
		return new JAXBElement<GetReply>(_GetReply_QNAME, GetReply.class, null, value);
	}

	/**
	 * Create an instance of {@link JAXBElement }{@code <}
	 * {@link GetReplyResponse }{@code >}}
	 * 
	 */
	@XmlElementDecl(namespace = "http://inter.foxcoon.com/", name = "getReplyResponse")
	public JAXBElement<GetReplyResponse> createGetReplyResponse(GetReplyResponse value) {
		return new JAXBElement<GetReplyResponse>(_GetReplyResponse_QNAME, GetReplyResponse.class, null, value);
	}

}
