package com.florei.api.model;

import java.io.Serializable;

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
@Table(name = "tb_transportistas")
public class Transportista implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@OneToOne(optional = false)
	@JoinColumn(name = "idPersonaNatural", unique = true)
	private PersonaNatural peNatural;

	@Column(columnDefinition = "char(9)")
	private String nroLicencia;

	@Embedded
	private Auditoria auditoria;

	public Transportista() {
	}

	public Transportista(PersonaNatural peNatural, String nroLicencia) {
		this.peNatural = peNatural;
		this.nroLicencia = nroLicencia;
	}

	public Transportista(PersonaNatural peNatural, String nroLicencia, Auditoria auditoria) {
		this.peNatural = peNatural;
		this.nroLicencia = nroLicencia;
		this.auditoria = auditoria;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public PersonaNatural getPeNatural() {
		return peNatural;
	}

	public void setPeNatural(PersonaNatural peNatural) {
		this.peNatural = peNatural;
	}

	public String getNroLicencia() {
		return nroLicencia;
	}

	public void setNroLicencia(String nroLicencia) {
		this.nroLicencia = nroLicencia;
	}

	public Auditoria getAuditoria() {
		return auditoria;
	}

	public void setAuditoria(Auditoria auditoria) {
		this.auditoria = auditoria;
	}

}
