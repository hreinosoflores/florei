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

import com.florei.api.model.DocumentoDetalle;
import com.florei.api.repo.DocumentoDetalleRepository;
import com.florei.api.util.Global;

@RestController
@RequestMapping(path = "/documentodetalle")
@CrossOrigin
public class DocumentoDetalleController {

	@Autowired
	private DocumentoDetalleRepository documentoDetalleRepository;

	@GetMapping()
	public Map<String, Object> findAll() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Global.resultOK(result, documentoDetalleRepository.findAll());
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PostMapping()
	public Map<String, Object> create(@RequestBody DocumentoDetalle documentoDetalle) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			documentoDetalle.getAuditoria().setActivo(true);
			documentoDetalle.getAuditoria().setFechaCreacion(new Date());

			Global.resultOK(result, documentoDetalleRepository.save(documentoDetalle));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PutMapping()
	public Map<String, Object> edit(@RequestBody DocumentoDetalle documentoDetalle) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			documentoDetalle.getAuditoria().setFechaModificacion(new Date());

			Global.resultOK(result, documentoDetalleRepository.save(documentoDetalle));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@DeleteMapping("/{id}")
	public Map<String, Object> delete(@PathVariable Long id) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			documentoDetalleRepository.deleteById(id);
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
			DocumentoDetalle documentoDetalle = documentoDetalleRepository.findById(id).orElse(null);
			if (documentoDetalle != null) {
				documentoDetalle.getAuditoria().setActivo(!documentoDetalle.getAuditoria().getActivo());
				documentoDetalle.getAuditoria().setFechaModificacion(new Date());
				documentoDetalle.getAuditoria().setUsuarioModificacion(usu);
				Global.resultOK(result, documentoDetalleRepository.save(documentoDetalle));
			}

		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

}
