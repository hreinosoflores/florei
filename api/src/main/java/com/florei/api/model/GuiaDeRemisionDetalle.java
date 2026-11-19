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
@Table(name = "tb_guia_de_remision_detalles")
public class GuiaDeRemisionDetalle implements Serializable {

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

	@Column(precision = 8, scale = 2)
	private BigDecimal pesoTotal;

	@Embedded
	private Auditoria auditoria;

	public GuiaDeRemisionDetalle() {
	}

	public GuiaDeRemisionDetalle(DocumentoDetalle documentoDetalle, BigDecimal pesoTotal) {
		this.documentoDetalle = documentoDetalle;
		this.pesoTotal = pesoTotal;
	}

	public GuiaDeRemisionDetalle(DocumentoDetalle documentoDetalle, BigDecimal pesoTotal, Auditoria auditoria) {
		this.documentoDetalle = documentoDetalle;
		this.pesoTotal = pesoTotal;
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

	public BigDecimal getPesoTotal() {
		return pesoTotal;
	}

	public void setPesoTotal(BigDecimal pesoTotal) {
		this.pesoTotal = pesoTotal;
	}

	public Auditoria getAuditoria() {
		return auditoria;
	}

	public void setAuditoria(Auditoria auditoria) {
		this.auditoria = auditoria;
	}

}
