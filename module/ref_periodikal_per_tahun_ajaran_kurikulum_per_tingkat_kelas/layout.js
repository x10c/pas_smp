/**
 * Copyright 2011 - Kementerian Pendidikan Nasional - Dit.PSMP
 *
 * Author(s):
 * + x10c-Lab
 *   - agus sugianto (agus.delonge@gmail.com)
 */

var m_ref_periodikal_per_tahun_ajaran_kurikulum_per_tingkat_kelas;
var m_ref_periodikal_per_tahun_ajaran_kurikulum_per_tingkat_kelas_d = _g_root +'/module/ref_periodikal_per_tahun_ajaran_kurikulum_per_tingkat_kelas/';

function M_RefPeriodikalPerTahunAjaranKurikulumPerTingkatKelas(title)
{
	this.title		= title;
	this.dml_type	= 0;
	this.ha_level	= 0;

	this.record = new Ext.data.Record.create([
			{ name	: 'kd_tahun_ajaran' }
		,	{ name	: 'kd_tingkat_kelas' }
		,	{ name	: 'nm_tingkat_kelas' }
		,	{ name	: 'kd_kurikulum' }
	]);

	this.store = new Ext.data.ArrayStore({
			fields		: this.record
		,	url			: m_ref_periodikal_per_tahun_ajaran_kurikulum_per_tingkat_kelas_d +'data.jsp'
		,	autoLoad	: false
	});
	
	this.store_kurikulum = new Ext.data.ArrayStore({
			fields		: ['id','name']
		,	url			: m_ref_periodikal_per_tahun_ajaran_kurikulum_per_tingkat_kelas_d +'data_kurikulum.jsp'
		,	idIndex		: 0
		,	autoLoad	: false
	});

	this.form_kurikulum = new Ext.form.ComboBox({
			store			: this.store_kurikulum
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	mode			: 'local'
		,	allowBlank		: false
		,	forceSelection	: true
		,	typeAhead		: true
		,	triggerAction	: 'all'
		,	selectOnFocus	: true
	});

	this.form_nm_tingkat_kelas = new Ext.form.TextField({});

	this.filters = new Ext.ux.grid.GridFilters({
			encode	: true
		,	local	: true
	});

	this.columns = [
			new Ext.grid.RowNumberer()
		,	{ header		: 'Kurikulum'
			, dataIndex		: 'kd_kurikulum'
			, sortable		: true
			, editor		: this.form_kurikulum
			, renderer		: combo_renderer(this.form_kurikulum)
			, width			: 150
			, filter		: {
					type		: 'list'
				,	store		: this.store_kurikulum
				,	labelField	: 'name'
				,	phpMode		: false
			 }
			}
		,	{ id			: 'nm_tingkat_kelas'
			, header		: 'Tingkat Kelas'
			, dataIndex		: 'nm_tingkat_kelas'
			, sortable		: true
			, editable		: false
			//, editor		: this.form_nm_tingkat_kelas			
			}
	];

	this.sm = new Ext.grid.RowSelectionModel({
		singleSelect	: true
	});

	this.editor = new MyRowEditor(this);

	this.btn_ref = new Ext.Button({
			text	: 'Refresh'
		,	iconCls	: 'refresh16'
		,	scope	: this
		,	handler	: function() {
				this.do_load();
			}
	});

	this.toolbar = new Ext.Toolbar({
		items	: [
			this.btn_ref
		]
	});

	this.panel = new Ext.grid.GridPanel({
			id			: 'ref_periodikal_per_tahun_ajaran_kurikulum_per_tingkat_kelas_panel'
		,	title		: this.title
		,	store		: this.store
		,	sm			: this.sm
		,	columns		: this.columns
		,	stripeRows	: true
		,	columnLines	: true
		,	plugins		: [this.editor, this.filters]
		,	tbar		: this.toolbar
		,	autoExpandColumn: 'nm_tingkat_kelas'
		,	listeners	: {
					scope		: this
				,	rowclick	:
						function (g, r, e) {
							return this.do_edit(r);
						}
			}
	});

	this.do_cancel = function()
	{
		if (this.dml_type == 2) {
			this.store.remove(this.record_new);
			this.sm.selectRow(0);
		}
	}

	this.do_save = function(record)
	{
		Ext.Ajax.request({
				params  : {
						kd_tahun_ajaran		: record.data['kd_tahun_ajaran']
					,	kd_tingkat_kelas	: record.data['kd_tingkat_kelas']
					,	kd_kurikulum		: record.data['kd_kurikulum']
					,	dml_type			: this.dml_type
				}
			,	url		: m_ref_periodikal_per_tahun_ajaran_kurikulum_per_tingkat_kelas_d +'submit.jsp'
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
		if (this.ha_level >= 3) {
			this.dml_type = 3;
			return true;
		}
		return false;
	}

	this.do_load = function()
	{
		this.store_kurikulum.load({
				callback	: function(){
					this.store.load();
				}
			,	scope		: this
		});		
	}

	this.do_refresh = function(ha_level)
	{
		this.ha_level = ha_level;

		if (this.ha_level < 1) {
			Ext.MessageBox.alert('Hak Akses', 'Maaf, Anda tidak memiliki hak akses untuk melihat menu ini!');
			this.panel.setDisabled(true);
			return;
		} else {
			this.panel.setDisabled(false);
		}

		this.do_load();
	}
}

m_ref_periodikal_per_tahun_ajaran_kurikulum_per_tingkat_kelas = new M_RefPeriodikalPerTahunAjaranKurikulumPerTingkatKelas('Kurikulum Per Tingkat Kelas');

//@ sourceURL=m_ref_periodikal_per_tahun_ajaran_kurikulum_per_tingkat_kelas.layout.js
