package com.florei.api.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.florei.api.model.CotizacionDetalle;
import com.florei.api.repo.CotizacionDetalleRepository;
import com.florei.api.util.Global;

@RestController
@RequestMapping(path = "/cotizaciondetalle")
@CrossOrigin
public class CotizacionDetalleController {

	@Autowired
	private CotizacionDetalleRepository cotizacionDetalleRepository;

	@GetMapping()
	public Map<String, Object> findAll() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Global.resultOK(result, cotizacionDetalleRepository.findAll());
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PostMapping()
	public Map<String, Object> create(@RequestBody CotizacionDetalle cotizacionDetalle) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			cotizacionDetalle.getAuditoria().setActivo(true);
			cotizacionDetalle.getAuditoria().setFechaCreacion(new Date());

			Global.resultOK(result, cotizacionDetalleRepository.save(cotizacionDetalle));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PutMapping()
	public Map<String, Object> edit(@RequestBody CotizacionDetalle cotizacionDetalle) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			cotizacionDetalle.getAuditoria().setFechaModificacion(new Date());

			Global.resultOK(result, cotizacionDetalleRepository.save(cotizacionDetalle));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@DeleteMapping("/{id}")
	public Map<String, Object> delete(@PathVariable Long id) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			cotizacionDetalleRepository.deleteById(id);
			Global.resultOK(result, id);
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PatchMapping("/activo/{usu}/{id}")
	public Map<String, Object> toggleActivo(@PathVariable Long usu, @PathVariable Long id) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			CotizacionDetalle cotizacionDetalle = cotizacionDetalleRepository.findById(id).orElse(null);
			if (cotizacionDetalle != null) {
				cotizacionDetalle.getAuditoria().setActivo(!cotizacionDetalle.getAuditoria().getActivo());
				cotizacionDetalle.getAuditoria().setFechaModificacion(new Date());
				cotizacionDetalle.getAuditoria().setUsuarioModificacion(usu);
				Global.resultOK(result, cotizacionDetalleRepository.save(cotizacionDetalle));
			}

		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

}
