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
@Table(name = "tb_boletas")
public class Boleta implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@OneToOne(optional = false)
	@JoinColumn(name = "idDocumento", unique = true)
	private Documento documento;

	@Column(precision = 8, scale = 2)
	private BigDecimal subtotal;

	@Column(precision = 8, scale = 2)
	private BigDecimal impuestos;

	@Column(precision = 8, scale = 2)
	private BigDecimal total;

	@Embedded
	private Auditoria auditoria;

	public Boleta(Documento documento, BigDecimal subtotal, BigDecimal impuestos, BigDecimal total) {
		this.documento = documento;
		this.subtotal = subtotal;
		this.impuestos = impuestos;
		this.total = total;
	}

	public Boleta(Documento documento, BigDecimal subtotal, BigDecimal impuestos, BigDecimal total,
			Auditoria auditoria) {
		this.documento = documento;
		this.subtotal = subtotal;
		this.impuestos = impuestos;
		this.total = total;
		this.auditoria = auditoria;
	}

	public Boleta() {
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Documento getDocumento() {
		return documento;
	}

	public void setDocumento(Documento documento) {
		this.documento = documento;
	}

	public BigDecimal getSubtotal() {
		return subtotal;
	}

	public void setSubtotal(BigDecimal subtotal) {
		this.subtotal = subtotal;
	}

	public BigDecimal getImpuestos() {
		return impuestos;
	}

	public void setImpuestos(BigDecimal impuestos) {
		this.impuestos = impuestos;
	}

	public BigDecimal getTotal() {
		return total;
	}

	public void setTotal(BigDecimal total) {
		this.total = total;
	}

	public Auditoria getAuditoria() {
		return auditoria;
	}

	public void setAuditoria(Auditoria auditoria) {
		this.auditoria = auditoria;
	}

}
