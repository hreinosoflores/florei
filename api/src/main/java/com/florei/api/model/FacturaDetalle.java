package com.florei.api.model;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.florei.api.util.Auditoria;

@Entity
@Table(name = "tb_factura_detalles")
public class FacturaDetalle implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@OneToOne(optional = false)
	@JoinColumn(name = "idDocumentoDetalle", unique = true)
	private DocumentoDetalle documentoDetalle;

	@Column(precision = 8, scale = 2, nullable = false)
	private BigDecimal precioUnitProdSoles;

	@Column(precision = 8, scale = 2)
	private BigDecimal subtotal;

	@Column(precision = 8, scale = 2)
	private BigDecimal impuestos;

	@Column(precision = 8, scale = 2)
	private BigDecimal total;

	@Embedded
	private Auditoria auditoria;

	public FacturaDetalle() {
	}

	public FacturaDetalle(DocumentoDetalle documentoDetalle, BigDecimal precioUnitProdSoles, BigDecimal subtotal,
			BigDecimal impuestos, BigDecimal total) {
		this.documentoDetalle = documentoDetalle;
		this.precioUnitProdSoles = precioUnitProdSoles;
		this.subtotal = subtotal;
		this.impuestos = impuestos;
		this.total = total;
	}

	public FacturaDetalle(DocumentoDetalle documentoDetalle, BigDecimal precioUnitProdSoles, BigDecimal subtotal,
			BigDecimal impuestos, BigDecimal total, Auditoria auditoria) {
		this.documentoDetalle = documentoDetalle;
		this.precioUnitProdSoles = precioUnitProdSoles;
		this.subtotal = subtotal;
		this.impuestos = impuestos;
		this.total = total;
		this.auditoria = auditoria;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public DocumentoDetalle getDocumentoDetalle() {
		return documentoDetalle;
	}

	public void setDocumentoDetalle(DocumentoDetalle documentoDetalle) {
		this.documentoDetalle = documentoDetalle;
	}

	public BigDecimal getPrecioUnitProdSoles() {
		return precioUnitProdSoles;
	}

	public void setPrecioUnitProdSoles(BigDecimal precioUnitProdSoles) {
		this.precioUnitProdSoles = precioUnitProdSoles;
	}

	public BigDecimal getSubtotalLinea() {
		return subtotal;
	}

	public void setSubtotalLinea(BigDecimal subtotal) {
		this.subtotal = subtotal;
	}

	public BigDecimal getImpuestosLinea() {
		return impuestos;
	}

	public void setImpuestosLinea(BigDecimal impuestos) {
		this.impuestos = impuestos;
	}

	public BigDecimal getTotalLinea() {
		return total;
	}

	public void setTotalLinea(BigDecimal total) {
		this.total = total;
	}

	public Auditoria getAuditoria() {
		return auditoria;
	}

	public void setAuditoria(Auditoria auditoria) {
		this.auditoria = auditoria;
	}
}
