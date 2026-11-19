package com.florei.api.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.florei.api.util.Auditoria;

@Entity
@Table(name = "tb_guias_de_remision")
public class GuiaDeRemision implements Serializable {

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

	@Column(nullable = false)
	@Temporal(TemporalType.TIMESTAMP)
	private Date horaTraslado;

	@Column(length = 200, nullable = false)
	private String lugarPartida;

	@Column(length = 200, nullable = false)
	private String lugarLlegada;

	@ManyToOne(optional = false)
	@JoinColumn(name = "idMotivo")
	private Motivo motivo;

	@ManyToOne(optional = false)
	@JoinColumn(name = "idTransportista")
	private Transportista transportista;

	@Embedded
	private Auditoria auditoria;

	public GuiaDeRemision() {
	}

	public GuiaDeRemision(Documento documento, Date horaTraslado, String lugarPartida, String lugarLlegada,
			Motivo motivo, Transportista transportista) {
		this.documento = documento;
		this.horaTraslado = horaTraslado;
		this.lugarPartida = lugarPartida;
		this.lugarLlegada = lugarLlegada;
		this.motivo = motivo;
		this.transportista = transportista;
	}

	public GuiaDeRemision(Documento documento, Date horaTraslado, String lugarPartida, String lugarLlegada,
			Motivo motivo, Transportista transportista, Auditoria auditoria) {
		this.documento = documento;
		this.horaTraslado = horaTraslado;
		this.lugarPartida = lugarPartida;
		this.lugarLlegada = lugarLlegada;
		this.motivo = motivo;
		this.transportista = transportista;
		this.auditoria = auditoria;
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

	public Date getHoraTraslado() {
		return horaTraslado;
	}

	public void setHoraTraslado(Date horaTraslado) {
		this.horaTraslado = horaTraslado;
	}

	public String getLugarPartida() {
		return lugarPartida;
	}

	public void setLugarPartida(String lugarPartida) {
		this.lugarPartida = lugarPartida;
	}

	public String getLugarLlegada() {
		return lugarLlegada;
	}

	public void setLugarLlegada(String lugarLlegada) {
		this.lugarLlegada = lugarLlegada;
	}

	public Motivo getMotivo() {
		return motivo;
	}

	public void setMotivo(Motivo motivo) {
		this.motivo = motivo;
	}

	public Transportista getTransportista() {
		return transportista;
	}

	public void setTransportista(Transportista transportista) {
		this.transportista = transportista;
	}

	public Auditoria getAuditoria() {
		return auditoria;
	}

	public void setAuditoria(Auditoria auditoria) {
		this.auditoria = auditoria;
	}

}
