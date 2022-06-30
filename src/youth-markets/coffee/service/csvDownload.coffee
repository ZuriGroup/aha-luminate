angular.module 'ahaLuminateApp'
  .factory 'CsvDownloadService', [
    '$rootScope'
    ($rootScope) ->
      ConvertToCSV = (objArray, headerList, fieldList) ->
        var index
        array = if typeof objArray != 'object' then JSON.parse(objArray) else objArray
        str = ''
        row = ''
        for index of headerList
          if index > 0
            row += ','
          row += headerList[index]
        row = row.slice(0, -1)
        str += row + '\u000d\n'
        i = 0
        while i < array.length
          line = ''
          for index of fieldList
            if index > 0
              line += ','
            head = fieldList[index]
            line += '"' + array[i][head] + '"'
          str += line + '\n'
          i++
        str

      downloadFile = (data, filename = 'data') ->
        csvData = @ConvertToCSV(data, 
                  ['First Name' 'Last Name' 'Teacher' 'Grade' 'Amount Raised' 'Completed'], 
                  ['first_name' 'last_name' 'teacher' 'grade' 'raisedf' 'completed'])
        blob = new Blob([ '\ufeff' + csvData ], type: 'text/csv;charset=utf-8;')
        dwldLink = document.createElement('a')
        url = URL.createObjectURL(blob)
        isSafariBrowser = navigator.userAgent.indexOf('Safari') != -1 and navigator.userAgent.indexOf('Chrome') == -1
        if isSafariBrowser
          dwldLink.setAttribute 'target', '_blank'
        dwldLink.setAttribute 'href', url
        dwldLink.setAttribute 'download', filename + '.csv'
        dwldLink.style.visibility = 'hidden'
        document.body.appendChild dwldLink
        dwldLink.click()
        document.body.removeChild dwldLink
        return
  ]
