<%
    errorMsg = error if error else None
%>

<%inherit file="lmkp:customization/lo/templates/base.mak" />

<%def name="title()">${_('Version Compare')}</%def>

<div class="container deal-moderate-content">
    <div class="content no-border">
        
        % if errorMsg:
            ${errorMsg | n}
        % else:
            ${self.topOfForm()}
            
            <div class="row-fluid">
                ${form | n}
            </div>

            <%
                try:
                    self.moderate_buttons()
                except AttributeError:
                    pass
            %>
        % endif
    </div>
</div>

<%def name="topOfForm()">
        
    <h3>${_('Version Compare')}</h3>
    <p class="id">${identifier}</p>

    <div class="row-fluid">
        <div class="span6">
            <div class="row-fluid">
                <ul class="nav nav-tabs table_tabs">
                    <li class="active">
                        <a href="" onclick="javascript:return false;">
                            % if refMetadata:
                                ${refMetadata['status']}
                            % else:
                                -
                            % endif
                        </a>
                    </li>
                </ul>
            </div>
            % if refMetadata:
            <div class="row-fluid">
                <div class="span12 grid-area border-bottom deal-data">
                    <div class="span5">
                        <h5 class="green">
                            ${_('Version')}
                        </h5>
                    </div>
                    <div class="span7">
                        ${refVersion}
                    </div>
                    <div class="row-fluid">
                        <div class="span5">
                            <h5 class="green moderate-metadata">
                                ${_('Timestamp')}
                            </h5>
                        </div>
                        <div class="span7">
                            ${refMetadata['timestamp']}
                        </div>
                    </div>
                    <div class="row-fluid">
                        <div class="span5">
                            <h5 class="green moderate-metadata">
                                ${_('User')}
                            </h5>
                        </div>
                        <div class="span7">
                            ${refMetadata['username']}
                        </div>
                    </div>
                </div>
            </div>
            % else:
            <div class="row-fluid">
                <div class="span12 grid-area deal-data">
                    ${_('There is no previous version available.')}
                </div>
            </div>
            % endif
        </div>
        <div class="span6">
            <div class="row-fluid">
                <div class="span9">
                    <ul class="nav nav-tabs table_tabs">
                        <li class="active">
                            <a href="" onclick="javascript:return false;">
                                ${newMetadata['status']}
                            </a>
                        </li>
                    </ul>
                </div>
                <div class="span3">
                    <ul class="nav nav-tabs table_tabs">
                        <li>
                            <a href="${request.route_url('activities_read_one_history', output='html', uid=identifier)}">${_('History')}</a>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="row-fluid">
                <div class="span12 grid-area border-bottom deal-data">
                    <div class="span5">
                        <h5 class="green">
                            ${_('Version')}
                        </h5>
                    </div>
                    <div class="span7">
                        ${newVersion}
                    </div>
                    <div class="row-fluid">
                        <div class="span5">
                            <h5 class="green moderate-metadata">
                                ${_('Timestamp')}
                            </h5>
                        </div>
                        <div class="span7">
                            ${newMetadata['timestamp']}
                        </div>
                    </div>
                    <div class="row-fluid">
                        <div class="span5">
                            <h5 class="green moderate-metadata">
                                ${_('User')}
                            </h5>
                        </div>
                        <div class="span7">
                            ${newMetadata['username']}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</%def>

<%def name="bottom_tags()">
    <%include file="lmkp:templates/map/mapform.mak" args="readonly=True, compare=True" />
    <script>
        
        var identifier = '${identifier}';
        var refVersion = ${refVersion};
        var newVersion = ${newVersion};

        $(document).ready(function(){
            
            % if refVersion and refMetadata:
                $('#refMapLegendEntry').html('${_("Version")} ${refVersion} (${refMetadata["status"]})');
                $('#refMapLegend').show();
            % endif
            % if newVersion and newMetadata:
                $('#newMapLegendEntry').html('${_("Version")} ${newVersion} (${newMetadata["status"]})');
                $('#newMapLegend').show();
            % endif
            
            $('.accordion').on('hidden', function() {
                $(this).find('.icon-chevron-up')
                    .removeClass("icon-chevron-up")
                    .addClass("icon-chevron-down");
            });

            $('.accordion').on('shown', function() {
                $(this).find('.icon-chevron-down')
                    .removeClass("icon-chevron-down")
                    .addClass("icon-chevron-up");
            });
        });
    </script>
</%def>