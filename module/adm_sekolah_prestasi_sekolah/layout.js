/**
 * Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 *
 * Author(s):
 * + x10c-Lab
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_adm_sekolah_prestasi_sekolah;
var m_adm_sekolah_prestasi_sekolah_prestasi_akademik;
var m_adm_sekolah_prestasi_sekolah_prestasi_non_akademik;
var m_adm_sekolah_prestasi_sekolah_peringkat_uan;
var m_adm_sekolah_prestasi_sekolah_d = _g_root +'/module/adm_sekolah_prestasi_sekolah/';
var m_adm_sekolah_prestasi_sekolah_ha_level = 0;

function M_AdmSekolahPrestasiSekolahPrestasiAkademik(title)
{
	this.title		= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'kd_tahun_ajaran' }
		,	{ name	: 'id_jenis_lomba' }
		,	{ name	: 'id_jenis_lomba_old' }
		,	{ name	: 'kd_tingkat_prestasi' }
		,	{ name	: 'kd_tingkat_prestasi_old' }
		,	{ name	: 'tanggal_prestasi' }
		,	{ name	: 'tanggal_prestasi_old' }
		,	{ name	: 'juara_ke' }
		,	{ name	: 'keterangan' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_adm_sekolah_prestasi_sekolah_d +'data_prestasi_akademik.jsp'
		,	autoLoad	: false
	});
	
	this.store_id_jenis_lomba = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_sekolah_prestasi_sekolah_d +'data_ref_jenis_lomba_akademik.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.store_kd_tingkat_prestasi = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_sekolah_prestasi_sekolah_d +'data_ref_tingkat_prestasi_sekolah.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.form_id_jenis_lomba = new Ext.form.ComboBox({
			store			: this.store_id_jenis_lomba
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	listWidth		: 400
	});

	this.form_kd_tingkat_prestasi = new Ext.form.ComboBox({
			store			: this.store_kd_tingkat_prestasi
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
	});

	this.form_tanggal_prestasi = new Ext.form.DateField({
			emptyText		: 'Y-m-d'
		,	format			: 'Y-m-d'
		,	allowBlank		: false
		,	invalidText		: 'Kolom ini harus berformat tanggal'
	});

	this.form_juara_ke = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 3
		,	maxLengthText	: 'Maksimal panjang kolom adalah 3'
	});

	this.form_keterangan = new Ext.form.TextField({});

	/* plugins */
	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
	});

	/* columns */
	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header		: 'Jenis Lomba'
			, dataIndex		: 'id_jenis_lomba'
			, sortable		: true
			, editor		: this.form_id_jenis_lomba
			, renderer		: combo_renderer(this.form_id_jenis_lomba)
			, width			: 250
			, filter		: {
					type		: 'list'
				,	store		: this.store_id_jenis_lomba
				,	labelField	: 'name'
				,	phpMode		: false
			 }
			}
		,	{ header		: 'Tingkat Prestasi'
			, dataIndex		: 'kd_tingkat_prestasi'
			, sortable		: true
			, editor		: this.form_kd_tingkat_prestasi
			, renderer		: combo_renderer(this.form_kd_tingkat_prestasi)
			, width			: 150
			, filter		: {
					type		: 'list'
				,	store		: this.store_kd_tingkat_prestasi
				,	labelField	: 'name'
				,	phpMode		: false
			 }
			}
		,	{ header		: 'Tanggal Prestasi'
			, dataIndex		: 'tanggal_prestasi'
			, sortable		: true
			, editor		: this.form_tanggal_prestasi
			, align			: 'center'
			, width			: 120
			, filter		: {
								type	: 'date'
							}
			}
		,	{ header		: 'Juara Ke'
			, dataIndex		: 'juara_ke'
			, sortable		: true
			, editor		: this.form_juara_ke
			, align			: 'center'
			, width			: 70
			, filter		: {
				type		: 'numeric'
			 }
			}
		,	{ id			: 'keterangan'
			, header		: 'Keterangan'
			, dataIndex		: 'keterangan'
			, sortable		: true
			, editor		: this.form_keterangan
			, filterable	: true
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length && m_adm_sekolah_prestasi_sekolah_ha_level == 4) {
						this.btn_del.setDisabled(false);
					} else {
						this.btn_del.setDisabled(true);
					}
				}
			}
	});

	this.editor = new MyRowEditor(this);

	this.btn_add = new Ext.Button({
			text	: 'Tambah'
		,	iconCls	: 'add16'
		,	scope	: this
		,	handler	: function() {
				this.do_add();
			}
	});

	this.btn_ref = new Ext.Button({
			text	: 'Refresh'
		,	iconCls	: 'refresh16'
		,	scope	: this
		,	handler	: function() {
				this.do_load();
			}
	});

	this.btn_del = new Ext.Button({
			text		: 'Hapus'
		,	iconCls		: 'del16'
		,	disabled	: true
		,	scope		: this
		,	handler		: function() {
				this.do_del();
			}
	});

	this.toolbar = new Ext.Toolbar({
		items	: [
			this.btn_ref
		,	'-'
		,	this.btn_add
		,	'-'
		,	this.btn_del
		]
	});

	this.panel = new Ext.grid.GridPanel({
			title		: this.title
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	stripeRows	: true
		,	columnLines	: true
		,	plugins		: [this.editor, this.filters]
		,	tbar		: this.toolbar
		,	autoExpandColumn: 'keterangan'
		,	listeners	: {
					scope		: this
				,	rowclick	:
						function (g, r, e) {
							return this.do_edit(r);
						}
			}
	});

	this.set_disabled = function()
	{
		this.btn_del.setDisabled(true);
		this.btn_ref.setDisabled(true);
		this.btn_add.setDisabled(true);
	}

	this.set_enabled = function()
	{
		this.btn_del.setDisabled(false);
		this.btn_ref.setDisabled(false);
		this.btn_add.setDisabled(false);
	}

	this.do_add = function()
	{
		this.record_new = new this.record({
				id_jenis_lomba		: ''
			,	kd_tingkat_prestasi	: ''
			,	tanggal_prestasi	: ''
			,	juara_ke			: ''
			,	keterangan			: ''
			});

		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);

		this.dml_type = 2;
		
		this.set_disabled();
	}

	this.do_del = function()
	{
		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}

		Ext.MessageBox.confirm('Konfirmasi', 'Hapus Data?', function(btn, text){
			if (btn == 'yes'){
				this.dml_type = 4;
				this.do_save(data[0]);
			}
		}, this);
	}

	this.do_cancel = function()
	{
		this.set_enabled();
		
		if (this.dml_type == 2) {
			this.store.remove(this.record_new);
			this.sm.selectRow(0);
		}
		
		this.set_button();
	}

	this.do_save = function(record)
	{
		this.set_enabled();
		
		if (m_adm_sekolah_prestasi_sekolah_ha_level < 2){
			Ext.Msg.alert("Perhatian", "Maaf, Anda tidak memiliki hak akses untuk melakukan proses ini!");
			this.do_load();
			return;
		}

		Ext.Ajax.request({
				params  : {
						id_jenis_lomba			: record.data['id_jenis_lomba']
					,	id_jenis_lomba_old		: record.data['id_jenis_lomba_old']
					,	kd_tingkat_prestasi		: record.data['kd_tingkat_prestasi']
					,	kd_tingkat_prestasi_old	: record.data['kd_tingkat_prestasi_old']
					,	tanggal_prestasi		: record.data['tanggal_prestasi']
					,	tanggal_prestasi_old	: record.data['tanggal_prestasi_old']
					,	juara_ke				: record.data['juara_ke']
					,	keterangan				: record.data['keterangan']
					,	dml_type				: this.dml_type
				}
			,	url		: m_adm_sekolah_prestasi_sekolah_d +'submit_prestasi_akademik.jsp'
			,	waitMsg	: 'Mohon Tunggu ...'
			,	success :
					function (response)
					{
						var msg = Ext.util.JSON.decode(response.responseText);

						if (msg.success == false) {
							Ext.MessageBox.alert('Pesan', msg.info);
						}

						this.do_load();
					}
			,	scope	: this
		});
	}

	this.do_edit = function(row)
	{
		if (m_adm_sekolah_prestasi_sekolah_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.set_button = function()
	{
		if (m_adm_sekolah_prestasi_sekolah_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_adm_sekolah_prestasi_sekolah_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}
	}

	this.do_load = function()
	{
		this.store_id_jenis_lomba.load({
			callback	: function(){
				this.store_kd_tingkat_prestasi.load({
					callback	: function(){
						this.store.load();
					}
				,	scope		: this
				});
			}
		,	scope		: this
		});
		
		this.set_button();
	}

	this.do_refresh = function()
	{
		if (m_adm_sekolah_prestasi_sekolah_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		this.do_load();
	}
}

function M_AdmSekolahPrestasiSekolahPrestasiNonAkademik(title)
{
	this.title		= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'kd_tahun_ajaran' }
		,	{ name	: 'id_jenis_lomba' }
		,	{ name	: 'id_jenis_lomba_old' }
		,	{ name	: 'kd_tingkat_prestasi' }
		,	{ name	: 'kd_tingkat_prestasi_old' }
		,	{ name	: 'tanggal_prestasi' }
		,	{ name	: 'tanggal_prestasi_old' }
		,	{ name	: 'juara_ke' }
		,	{ name	: 'keterangan' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_adm_sekolah_prestasi_sekolah_d +'data_prestasi_non_akademik.jsp'
		,	autoLoad	: false
	});
	
	this.store_id_jenis_lomba = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_sekolah_prestasi_sekolah_d +'data_ref_jenis_lomba_non_akademik.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.store_kd_tingkat_prestasi = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_sekolah_prestasi_sekolah_d +'data_ref_tingkat_prestasi_sekolah.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.form_id_jenis_lomba = new Ext.form.ComboBox({
			store			: this.store_id_jenis_lomba
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
		,	listWidth		: 400
	});

	this.form_kd_tingkat_prestasi = new Ext.form.ComboBox({
			store			: this.store_kd_tingkat_prestasi
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
	});

	this.form_tanggal_prestasi = new Ext.form.DateField({
			emptyText		: 'Y-m-d'
		,	format			: 'Y-m-d'
		,	allowBlank		: false
		,	invalidText		: 'Kolom ini harus berformat tanggal'
	});

	this.form_juara_ke = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxLength		: 3
		,	maxLengthText	: 'Maksimal panjang kolom adalah 3'
	});

	this.form_keterangan = new Ext.form.TextField({});

	/* plugins */
	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
	});

	/* columns */
	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header		: 'Jenis Lomba'
			, dataIndex		: 'id_jenis_lomba'
			, sortable		: true
			, editor		: this.form_id_jenis_lomba
			, renderer		: combo_renderer(this.form_id_jenis_lomba)
			, width			: 250
			, filter		: {
					type		: 'list'
				,	store		: this.store_id_jenis_lomba
				,	labelField	: 'name'
				,	phpMode		: false
			 }
			}
		,	{ header		: 'Tingkat Prestasi'
			, dataIndex		: 'kd_tingkat_prestasi'
			, sortable		: true
			, editor		: this.form_kd_tingkat_prestasi
			, renderer		: combo_renderer(this.form_kd_tingkat_prestasi)
			, width			: 150
			, filter		: {
					type		: 'list'
				,	store		: this.store_kd_tingkat_prestasi
				,	labelField	: 'name'
				,	phpMode		: false
			 }
			}
		,	{ header		: 'Tanggal Prestasi'
			, dataIndex		: 'tanggal_prestasi'
			, sortable		: true
			, editor		: this.form_tanggal_prestasi
			, align			: 'center'
			, width			: 120
			, filter		: {
								type	: 'date'
							}
			}
		,	{ header		: 'Juara Ke'
			, dataIndex		: 'juara_ke'
			, sortable		: true
			, editor		: this.form_juara_ke
			, align			: 'center'
			, width			: 70
			, filter		: {
				type		: 'numeric'
			 }
			}
		,	{ id			: 'keterangan'
			, header		: 'Keterangan'
			, dataIndex		: 'keterangan'
			, sortable		: true
			, editor		: this.form_keterangan
			, filterable	: true
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length && m_adm_sekolah_prestasi_sekolah_ha_level == 4) {
						this.btn_del.setDisabled(false);
					} else {
						this.btn_del.setDisabled(true);
					}
				}
			}
	});

	this.editor = new MyRowEditor(this);

	this.btn_add = new Ext.Button({
			text	: 'Tambah'
		,	iconCls	: 'add16'
		,	scope	: this
		,	handler	: function() {
				this.do_add();
			}
	});

	this.btn_ref = new Ext.Button({
			text	: 'Refresh'
		,	iconCls	: 'refresh16'
		,	scope	: this
		,	handler	: function() {
				this.do_load();
			}
	});

	this.btn_del = new Ext.Button({
			text		: 'Hapus'
		,	iconCls		: 'del16'
		,	disabled	: true
		,	scope		: this
		,	handler		: function() {
				this.do_del();
			}
	});

	this.toolbar = new Ext.Toolbar({
		items	: [
			this.btn_ref
		,	'-'
		,	this.btn_add
		,	'-'
		,	this.btn_del
		]
	});

	this.panel = new Ext.grid.GridPanel({
			title		: this.title
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	stripeRows	: true
		,	columnLines	: true
		,	plugins		: [this.editor, this.filters]
		,	tbar		: this.toolbar
		,	autoExpandColumn: 'keterangan'
		,	listeners	: {
					scope		: this
				,	rowclick	:
						function (g, r, e) {
							return this.do_edit(r);
						}
			}
	});

	this.set_disabled = function()
	{
		this.btn_del.setDisabled(true);
		this.btn_ref.setDisabled(true);
		this.btn_add.setDisabled(true);
	}

	this.set_enabled = function()
	{
		this.btn_del.setDisabled(false);
		this.btn_ref.setDisabled(false);
		this.btn_add.setDisabled(false);
	}

	this.do_add = function()
	{
		this.record_new = new this.record({
				id_jenis_lomba		: ''
			,	kd_tingkat_prestasi	: ''
			,	tanggal_prestasi	: ''
			,	juara_ke			: ''
			,	keterangan			: ''
			});

		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);

		this.dml_type = 2;
		
		this.set_disabled();
	}

	this.do_del = function()
	{
		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}

		Ext.MessageBox.confirm('Konfirmasi', 'Hapus Data?', function(btn, text){
			if (btn == 'yes'){
				this.dml_type = 4;
				this.do_save(data[0]);
			}
		}, this);
	}

	this.do_cancel = function()
	{
		this.set_enabled();
		
		if (this.dml_type == 2) {
			this.store.remove(this.record_new);
			this.sm.selectRow(0);
		}
		
		this.set_button();
	}

	this.do_save = function(record)
	{
		this.set_enabled();
		
		if (m_adm_sekolah_prestasi_sekolah_ha_level < 2){
			Ext.Msg.alert("Perhatian", "Maaf, Anda tidak memiliki hak akses untuk melakukan proses ini!");
			this.do_load();
			return;
		}

		Ext.Ajax.request({
				params  : {
						id_jenis_lomba			: record.data['id_jenis_lomba']
					,	id_jenis_lomba_old		: record.data['id_jenis_lomba_old']
					,	kd_tingkat_prestasi		: record.data['kd_tingkat_prestasi']
					,	kd_tingkat_prestasi_old	: record.data['kd_tingkat_prestasi_old']
					,	tanggal_prestasi		: record.data['tanggal_prestasi']
					,	tanggal_prestasi_old	: record.data['tanggal_prestasi_old']
					,	juara_ke				: record.data['juara_ke']
					,	keterangan				: record.data['keterangan']
					,	dml_type				: this.dml_type
				}
			,	url		: m_adm_sekolah_prestasi_sekolah_d +'submit_prestasi_non_akademik.jsp'
			,	waitMsg	: 'Mohon Tunggu ...'
			,	success :
					function (response)
					{
						var msg = Ext.util.JSON.decode(response.responseText);

						if (msg.success == false) {
							Ext.MessageBox.alert('Pesan', msg.info);
						}

						this.do_load();
					}
			,	scope	: this
		});
	}

	this.do_edit = function(row)
	{
		if (m_adm_sekolah_prestasi_sekolah_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.set_button = function()
	{
		if (m_adm_sekolah_prestasi_sekolah_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_adm_sekolah_prestasi_sekolah_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}
	}

	this.do_load = function()
	{
		this.store_id_jenis_lomba.load({
			callback	: function(){
				this.store_kd_tingkat_prestasi.load({
					callback	: function(){
						this.store.load();
					}
				,	scope		: this
				});
			}
		,	scope		: this
		});
		
		this.set_button();
	}

	this.do_refresh = function()
	{
		if (m_adm_sekolah_prestasi_sekolah_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		this.do_load();
	}
}

function M_AdmSekolahPrestasiSekolahPeringkatUAN(title)
{
	this.title		= title;
	this.dml_type	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'kd_tahun_ajaran' }
		,	{ name	: 'kd_tingkat_prestasi' }
		,	{ name	: 'kd_tingkat_prestasi_old' }
		,	{ name	: 'peringkat_sejenis' }
		,	{ name	: 'peringkat_gabungan' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_adm_sekolah_prestasi_sekolah_d +'data_peringkat_uan.jsp'
		,	autoLoad	: false
	});
	
	this.store_kd_tingkat_prestasi = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_adm_sekolah_prestasi_sekolah_d +'data_ref_tingkat_prestasi_sekolah_uan.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.form_kd_tingkat_prestasi = new Ext.form.ComboBox({
			store			: this.store_kd_tingkat_prestasi
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
	});

	this.form_peringkat_sejenis = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxValue		: 255
		,	maxText			: 'Nilai Maksimal adalah 255'
	});

	this.form_peringkat_gabungan = new Ext.form.NumberField({
			allowBlank		: false
		,	allowDecimals	: false
		,	allowNegative	: false
		,	maxValue		: 255
		,	maxText			: 'Nilai Maksimal adalah 255'
	});

	/* plugins */
	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
	});

	/* columns */
	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header		: 'Tingkat Prestasi'
			, dataIndex		: 'kd_tingkat_prestasi'
			, sortable		: true
			, editor		: this.form_kd_tingkat_prestasi
			, renderer		: combo_renderer(this.form_kd_tingkat_prestasi)
			, width			: 150
			, filter		: {
					type		: 'list'
				,	store		: this.store_kd_tingkat_prestasi
				,	labelField	: 'name'
				,	phpMode		: false
			 }
			}
		,	{ header		: 'Peringkat Sejenis'
			, dataIndex		: 'peringkat_sejenis'
			, sortable		: true
			, editor		: this.form_peringkat_sejenis
			, align			: 'center'
			, width			: 150
			, filter		: {
				type		: 'numeric'
			 }
			}
		,	{ header		: 'Peringkat Gabungan'
			, dataIndex		: 'peringkat_gabungan'
			, sortable		: true
			, editor		: this.form_peringkat_gabungan
			, align			: 'center'
			, width			: 150
			, filter		: {
				type		: 'numeric'
			 }
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
			singleSelect	: true
		,	listeners	: {
				scope		: this
			,	selectionchange	: function(sm) {
					var data = sm.getSelections();
					if (data.length && m_adm_sekolah_prestasi_sekolah_ha_level == 4) {
						this.btn_del.setDisabled(false);
					} else {
						this.btn_del.setDisabled(true);
					}
				}
			}
	});

	this.editor = new MyRowEditor(this);

	this.btn_add = new Ext.Button({
			text	: 'Tambah'
		,	iconCls	: 'add16'
		,	scope	: this
		,	handler	: function() {
				this.do_add();
			}
	});

	this.btn_ref = new Ext.Button({
			text	: 'Refresh'
		,	iconCls	: 'refresh16'
		,	scope	: this
		,	handler	: function() {
				this.do_load();
			}
	});

	this.btn_del = new Ext.Button({
			text		: 'Hapus'
		,	iconCls		: 'del16'
		,	disabled	: true
		,	scope		: this
		,	handler		: function() {
				this.do_del();
			}
	});

	this.toolbar = new Ext.Toolbar({
		items	: [
			this.btn_ref
		,	'-'
		,	this.btn_add
		,	'-'
		,	this.btn_del
		]
	});

	this.panel = new Ext.grid.GridPanel({
			title		: this.title
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	stripeRows	: true
		,	columnLines	: true
		,	plugins		: [this.editor, this.filters]
		,	tbar		: this.toolbar
		,	listeners	: {
					scope		: this
				,	rowclick	:
						function (g, r, e) {
							return this.do_edit(r);
						}
			}
	});

	this.set_disabled = function()
	{
		this.btn_del.setDisabled(true);
		this.btn_ref.setDisabled(true);
		this.btn_add.setDisabled(true);
	}

	this.set_enabled = function()
	{
		this.btn_del.setDisabled(false);
		this.btn_ref.setDisabled(false);
		this.btn_add.setDisabled(false);
	}

	this.do_add = function()
	{
		this.record_new = new this.record({
				kd_tingkat_prestasi	: ''
			,	peringkat_sejenis	: ''
			,	peringkat_gabungan	: ''
			});

		this.editor.stopEditing();
		this.store.insert(0, this.record_new);
		this.sm.selectRow(0);
		this.editor.startEditing(0);

		this.dml_type = 2;
		
		this.set_disabled();
	}

	this.do_del = function()
	{
		var data = this.sm.getSelections();
		if (!data.length) {
			return;
		}

		Ext.MessageBox.confirm('Konfirmasi', 'Hapus Data?', function(btn, text){
			if (btn == 'yes'){
				this.dml_type = 4;
				this.do_save(data[0]);
			}
		}, this);
	}

	this.do_cancel = function()
	{
		this.set_enabled();
		
		if (this.dml_type == 2) {
			this.store.remove(this.record_new);
			this.sm.selectRow(0);
		}
		
		this.set_button();
	}

	this.do_save = function(record)
	{
		this.set_enabled();
		
		if (m_adm_sekolah_prestasi_sekolah_ha_level < 2){
			Ext.Msg.alert("Perhatian", "Maaf, Anda tidak memiliki hak akses untuk melakukan proses ini!");
			this.do_load();
			return;
		}

		Ext.Ajax.request({
				params  : {
						kd_tingkat_prestasi		: record.data['kd_tingkat_prestasi']
					,	kd_tingkat_prestasi_old	: record.data['kd_tingkat_prestasi_old']
					,	peringkat_sejenis		: record.data['peringkat_sejenis']
					,	peringkat_gabungan		: record.data['peringkat_gabungan']
					,	dml_type				: this.dml_type
				}
			,	url		: m_adm_sekolah_prestasi_sekolah_d +'submit_peringkat_uan.jsp'
			,	waitMsg	: 'Mohon Tunggu ...'
			,	success :
					function (response)
					{
						var msg = Ext.util.JSON.decode(response.responseText);

						if (msg.success == false) {
							Ext.MessageBox.alert('Pesan', msg.info);
						}

						this.do_load();
					}
			,	scope	: this
		});
	}

	this.do_edit = function(row)
	{
		if (m_adm_sekolah_prestasi_sekolah_ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.set_button = function()
	{
		if (m_adm_sekolah_prestasi_sekolah_ha_level >= 2) {
			this.btn_add.setDisabled(false);
		} else {
			this.btn_add.setDisabled(true);
		}

		if (m_adm_sekolah_prestasi_sekolah_ha_level == 4) {
			this.btn_del.setDisabled(false);
		} else {
			this.btn_del.setDisabled(true);
		}
	}

	this.do_load = function()
	{
		this.store_kd_tingkat_prestasi.load({
			callback	: function(){
				this.store.load();
			}
		,	scope		: this
		});
		
		this.set_button();
	}

	this.do_refresh = function()
	{
		if (m_adm_sekolah_prestasi_sekolah_ha_level < 1) {
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		this.do_load();
	}
}

function M_AdmSekolahPrestasiSekolah()
{
	m_adm_sekolah_prestasi_sekolah_prestasi_akademik		= new M_AdmSekolahPrestasiSekolahPrestasiAkademik('Prestasi Akademik');
	m_adm_sekolah_prestasi_sekolah_prestasi_non_akademik	= new M_AdmSekolahPrestasiSekolahPrestasiNonAkademik('Prestasi Non Akademik');
	m_adm_sekolah_prestasi_sekolah_peringkat_uan			= new M_AdmSekolahPrestasiSekolahPeringkatUAN('Peringkat UAN');

	this.panel = new Ext.TabPanel({
			id				: 'adm_sekolah_prestasi_sekolah_panel'
		,	enableTabScroll	: true
        ,	activeTab		: 0
		,	defaults		: {
				loadMask		: {msg: 'Pemuatan...'}
			,	split			: true
			,	autoScroll		: true
			,	animScroll		: true
    		}
		,	items			: [
				m_adm_sekolah_prestasi_sekolah_prestasi_akademik.panel
			,	m_adm_sekolah_prestasi_sekolah_prestasi_non_akademik.panel
			,	m_adm_sekolah_prestasi_sekolah_peringkat_uan.panel
			]
	});
	
	this.do_check = function()
	{
		Ext.Ajax.request({
			url		: m_adm_sekolah_prestasi_sekolah_d +'data_ref_sekolah.jsp'
		,	waitMsg	: 'Pemuatan ...'
		,	failure	: function(response) {
				Ext.MessageBox.alert('Gagal', response.responseText);
			}
		,	success : function (response) {
				var msg = Ext.util.JSON.decode(response.responseText);
				
				if (msg.success == false) {
					Ext.MessageBox.alert('Pesan', msg.info);
					this.panel.setDisabled(true);
					return;
				}				
			}
		,	scope	: this		
		});
	}
	
	this.do_refresh = function(ha_level)
	{
		m_adm_sekolah_prestasi_sekolah_ha_level = ha_level;
		
		m_adm_sekolah_prestasi_sekolah_prestasi_akademik.do_refresh();
		m_adm_sekolah_prestasi_sekolah_prestasi_non_akademik.do_refresh();
		m_adm_sekolah_prestasi_sekolah_peringkat_uan.do_refresh();
		
		this.do_check();
	}
}

m_adm_sekolah_prestasi_sekolah = new M_AdmSekolahPrestasiSekolah();

//@ sourceURL=adm_sekolah_prestasi_sekolah.layout.js
