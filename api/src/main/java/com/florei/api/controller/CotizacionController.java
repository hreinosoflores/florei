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

import com.florei.api.model.Cotizacion;
import com.florei.api.repo.CotizacionRepository;
import com.florei.api.util.Global;

@RestController
@RequestMapping(path = "/cotizacion")
@CrossOrigin
public class CotizacionController {
	@Autowired
	private CotizacionRepository cotizacionRepository;

	@GetMapping()
	public Map<String, Object> findAll() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Global.resultOK(result, cotizacionRepository.findAll());
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PostMapping()
	public Map<String, Object> create(@RequestBody Cotizacion cotizacion) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			cotizacion.getAuditoria().setActivo(true);
			cotizacion.getAuditoria().setFechaCreacion(new Date());

			Global.resultOK(result, cotizacionRepository.save(cotizacion));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PutMapping()
	public Map<String, Object> edit(@RequestBody Cotizacion cotizacion) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			cotizacion.getAuditoria().setFechaModificacion(new Date());

			Global.resultOK(result, cotizacionRepository.save(cotizacion));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@DeleteMapping("/{id}")
	public Map<String, Object> delete(@PathVariable Long id) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			cotizacionRepository.deleteById(id);
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
			Cotizacion cotizacion = cotizacionRepository.findById(id).orElse(null);
			if (cotizacion != null) {
				cotizacion.getAuditoria().setActivo(!cotizacion.getAuditoria().getActivo());
				cotizacion.getAuditoria().setFechaModificacion(new Date());
				cotizacion.getAuditoria().setUsuarioModificacion(usu);
				Global.resultOK(result, cotizacionRepository.save(cotizacion));
			}

		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

}
