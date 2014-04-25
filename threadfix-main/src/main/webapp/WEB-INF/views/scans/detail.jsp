<%@ include file="/common/taglibs.jsp"%>

<head>
	<title>Scan Details</title>
	<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/scan-detail-page-controller.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/scripts/scan-mapped-finding-table-controller.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/scripts/scan-unmapped-finding-table-controller.js"></script>
</head>

<body id="scanDetail"
      ng-controller="ScanDetailPageController" ng-init="showStatistic = false; statisticText = 'Show Statistics'">

    <%@ include file="/WEB-INF/views/angular-init.jspf"%>

	<spring:url value="/organizations/{orgId}" var="orgUrl">
		<spring:param name="orgId" value="${ scan.application.organization.id }" />
	</spring:url>
	<spring:url value="/organizations/{orgId}/applications/{appId}" var="appUrl">
		<spring:param name="orgId" value="${ scan.application.organization.id }" />
		<spring:param name="appId" value="${ scan.application.id }" />
	</spring:url>

	<ul class="breadcrumb">
	    <li><a href="<spring:url value="/organizations"/>">Applications Index</a> <span class="divider">/</span></li>
	    <li><a href="${ fn:escapeXml(orgUrl) }">Team: <c:out value="${ scan.application.organization.name }"/></a> <span class="divider">/</span></li>
	    <li><a href="${ fn:escapeXml(appUrl) }">Application: <c:out value="${ scan.application.name }"/></a><span class="divider">/</span></li>
	    <li class="active"><fmt:formatDate value="${ scan.importTime.time }" type="both" dateStyle="short" timeStyle="short"/> <c:out value="${ fn:escapeXml(scan.applicationChannel.channelType.name) }"/> Scan</li>
    </ul>

	<h2><fmt:formatDate value="${ scan.importTime.time }" type="both" dateStyle="short" timeStyle="short"/> 
	<c:out value="${ fn:escapeXml(scan.applicationChannel.channelType.name) }"/> Scan Findings
		<span>
			<a ng-click="statistic()" id="statisticButton" class="btn header-button" >{{ statisticText }}</a>
			<a ng-click="deleteScan()" class="btn btn-danger header-button">Delete Scan</a>
		</span>
	</h2>
	
	<spring:url value="{scanId}/delete" var="deleteUrl">
		<spring:param name="scanId" value="${ scan.id }"/>
	</spring:url>
	<form id="deleteForm" method="POST" action="${ fn:escapeXml(deleteUrl) }"></form>

	<div id="helpText">
		This page lists various statistics about a set of scan results from one scan file.<br/>
	</div>

	<div class="container-fluid">
		<div ng-show="showStatistic" id="statisticsDiv" class="row-fluid">
			<div class="span4">
				<h4>Import Statistics</h4>
				<table class="dataTable">
					<tbody>
						<tr>
							<td>Imported Results</td>
							<td class="inputValue">
								<c:out value="${ scan.numberRepeatResults + scan.totalNumberSkippedResults + 
													totalFindings + scan.numWithoutChannelVulns + scan.numWithoutGenericMappings }"/>
							</td>
						</tr>
						<tr>
							<td>Duplicate Results</td>
							<td class="inputValue"><c:out value="${ scan.numberRepeatResults + scan.totalNumberSkippedResults }"/></td>
						</tr>
						<tr>
							<td style="font-weight:bold">Total Findings</td>
							<td class="inputValue"><c:out value="${ totalFindings + 
														scan.numWithoutChannelVulns + scan.numWithoutGenericMappings }"/></td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="span4">
				<h4>Finding Statistics</h4>
				<table class="dataTable">
					<tbody>
						<tr>
							<td>Findings without Vulnerabilities</td>
							<td class="inputValue"><c:out value="${ scan.numWithoutChannelVulns + scan.numWithoutGenericMappings }"/></td>
						</tr>
						<tr>
							<td>Findings with Vulnerabilities</td>
							<td class="inputValue"><c:out value="${ totalFindings }"/></td>
						</tr>
						<tr>
							<td>Duplicate Findings</td>
							<td class="inputValue"><c:out value="${ totalFindings - vulnData[1] - scan.numberHiddenVulnerabilities }"/></td>
						</tr>
						<tr>
							<td>Hidden Vulnerabilities</td>
							<td class="inputValue"><c:out value="${ scan.numberHiddenVulnerabilities }"/></td>
						</tr>
						<tr>
							<td style="font-weight:bold">Total Vulnerabilities</td>
							<td class="inputValue"><c:out value="${ vulnData[1] }"/></td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="span4">
				<h4>Vulnerability Statistics</h4>
				<table class="dataTable">
					<tbody>
						<tr>
							<td>New Vulnerabilities</td>
							<td class="inputValue"><c:out value="${ vulnData[2] }"/></td>
						</tr>
						<tr>
							<td>Old Vulnerabilities</td>
							<td class="inputValue"><c:out value="${ vulnData[3] }"/></td>
						</tr>
						<tr>
							<td>Resurfaced Vulnerabilities</td>
							<td class="inputValue"><c:out value="${ vulnData[4] }"/></td>
						</tr>
						<tr>
							<td>Closed Vulnerabilities</td>
							<td class="inputValue"><c:out value="${ vulnData[5] }"/></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	
		<div class="row-fluid">
			<c:if test="${ totalFindings + scan.numWithoutChannelVulns + scan.numWithoutGenericMappings == 0 }">
				<div id="toReplace">
				<h4>Findings</h4>
				<table class="table table-striped" id="1">
					<thead>
						<tr>
							<th class="first">Severity</th>
							<th>Vulnerability Type</th>
							<th>Path</th>
							<th>Parameter</th>
							<th class="last">Number Merged Results</th>
						</tr>
					</thead>
					<tbody>
						<tr class="bodyRow">
							<c:if test="${ scan.numberRepeatFindings != 0 }">
								<td colspan="6" style="text-align: center;">All Findings were linked to Findings from previous scans.</td>
							</c:if>
							<c:if test="${ scan.numberRepeatFindings == 0 }">
								<td colspan="6" style="text-align: center;">No Findings were found.</td>
							</c:if>
						</tr>
					</tbody>
				</table>
				</div>
			</c:if>

			<c:if test="${ totalFindings + scan.numWithoutChannelVulns + scan.numWithoutGenericMappings != 0}">
                <div>
                    <%@ include file="/WEB-INF/views/scans/table.jsp" %>
                </div>
                <div>
                    <%@ include file="/WEB-INF/views/scans/unmappedTable.jsp" %>
                </div>
			</c:if>
		</div>
	</div>
</body>
