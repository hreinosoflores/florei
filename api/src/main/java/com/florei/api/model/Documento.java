package com.florei.api.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.florei.api.util.Auditoria;
import com.florei.api.util.Constantes;

@Entity
@Table(name = "tb_documentos")
public class Documento implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(nullable = false)
	private Short estado = Constantes.defaultShort_1;

	@Column(columnDefinition = "text")
	private String comentarios;

	@ManyToOne
	@JoinColumn(name = "idClienteNat")
	private ClienteNatural clienteNat;

	@ManyToOne
	@JoinColumn(name = "idClienteJur")
	private ClienteJuridico clienteJur;

	@Embedded
	private Auditoria auditoria;

	public Documento() {
	}

	public Documento(Short estado, String comentarios, ClienteNatural clienteNat, ClienteJuridico clienteJur) {
		this.estado = estado;
		this.comentarios = comentarios;
		this.clienteNat = clienteNat;
		this.clienteJur = clienteJur;
	}

	public Documento(Short estado, String comentarios, ClienteNatural clienteNat, ClienteJuridico clienteJur,
			Auditoria auditoria) {
		this.estado = estado;
		this.comentarios = comentarios;
		this.clienteNat = clienteNat;
		this.clienteJur = clienteJur;
		this.auditoria = auditoria;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Short getEstado() {
		return estado;
	}

	public void setEstado(Short estado) {
		this.estado = estado;
	}

	public String getComentarios() {
		return comentarios;
	}

	public void setComentarios(String comentarios) {
		this.comentarios = comentarios;
	}

	public ClienteNatural getClienteNat() {
		return clienteNat;
	}

	public void setClienteNat(ClienteNatural clienteNat) {
		this.clienteNat = clienteNat;
	}

	public ClienteJuridico getClienteJur() {
		return clienteJur;
	}

	public void setClienteJur(ClienteJuridico clienteJur) {
		this.clienteJur = clienteJur;
	}

	public Auditoria getAuditoria() {
		return auditoria;
	}

	public void setAuditoria(Auditoria auditoria) {
		this.auditoria = auditoria;
	}
}
